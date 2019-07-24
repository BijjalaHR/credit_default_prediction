library(readxl)
default_of_credit_card_clients <- read_excel("cc_def_pred/default of credit card clients.xls")
# Data Import
init_df <- data.frame(default_of_credit_card_clients)

colnames(init_df) = init_df[1, ]
# Making first row as column names
init_df = init_df[-1, ]
# Removing the first row because it is column names
cc_df <- init_df[,-1]
# Making a new dataframe without the first column
# First column is IDs, just continuoues number. First column is not necessary to feed to neural network
rownames(cc_df) <- init_df[,1]
# Using IDs as row names of new dataframe
colnames(cc_df)[24] <- "default_payment_next_month"
# Removing spaces in last column name

library(DataExplorer)
introduce(cc_df)
# No missing values are present
# No continuous columns because the data is in strings, not numeric

for(i in 1:24){
  cc_df[,i] <- as.numeric(cc_df[,i])
}
introduce(cc_df)
# Now, all columns are numeric

normalize <- function(x) {
  return ((x - min(x)) / (max(x) - min(x)))
}
# Creating a function to normalize the data
norm_cc <- as.data.frame(lapply(cc_df, normalize))
# Now data is normalized, all values between 0 and 1

library(caret)
set.seed(102)
intrain <- createDataPartition(y=norm_cc$default_payment_next_month,p=0.75,list=FALSE)
training <- norm_cc[intrain,]
testing <- norm_cc[-intrain,]
# training and testing data are split in 3:1 ratio
# The split is done according to the labels

table(training$default_payment_next_month)
table(testing$default_payment_next_month)
# There is a big class imbalance

X_train <- as.matrix(training[,1:23])
X_test <- as.matrix(testing[,1:23])
# Matrix conversion is necessary for the neural network to read the data

library(keras)
y_train <- as.matrix(to_categorical(training$default_payment_next_month))
y_test <- to_categorical(testing$default_payment_next_month)
# Previously labels are 0s and 1s in one column
# Labels are split to 2 columns, so that each row has 1 in one of the two columns

model <- keras_model_sequential() 
model %>% 
  layer_dense(units = 23, activation = 'relu', input_shape = ncol(X_train)) %>% 
  layer_dense(units = 15, activation = 'relu') %>%
  layer_dense(units = 6, activation = 'relu') %>%
  layer_dense(units = 2, activation = 'relu') %>%
  layer_dense(units = 2, activation = 'softmax')
my_net <- model %>% compile(loss = 'binary_crossentropy', optimizer = optimizer_adam(lr=0.001), 
                            metrics = c('accuracy'))
# A dense/fully-connected neural network is created

summary(model)
# Some of the neural network parameters can be seen

#model %>% fit(X_train, y_train, epochs = 100, batch_size = 36, validation_split = 0.25)
model %>% fit(X_train, y_train, epochs = 100, batch_size = 36)
# Neural network is trained

model %>% evaluate(X_test, y_test)
# Loss and accuracy of prediction of test data

predictions <- model %>% predict_classes(X_test)
table(factor(predictions, levels=min(testing$default_payment_next_month):max(testing$default_payment_next_month)),
      factor(testing$default_payment_next_month, 
             levels=min(testing$default_payment_next_month):max(testing$default_payment_next_month)))
# Gives a confusion matrix on predictions of test data