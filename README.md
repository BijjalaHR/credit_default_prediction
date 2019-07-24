# Prediction of default payment of credit card

This is binary classification task of predicting whether the Credit card holder will pay the current default. A small fully-coneected neural network is developed in R and used for binary classification.

## Data

The data is taken from [UCI Machine Learning Repository](https://archive.ics.uci.edu/ml/datasets/default+of+credit+card+clients). 

The data has 30000 samples and 25 attributes (including labels). The attributes are as follows.

Column | Content |
--- | --- |
X1 | ID |
X2 | Total Credit Limit |
X3 | Gender |
X4 | Education Level |
X5 | Marital Status |
X6 | Age |
X7-12 | Payments of past 6 months, scaled from -1 to 9 |
X13-18 | Bill amount of past 6 months |
X19-24 | Payment amount of past 6 months |
X25 | Default payment |

For more information about the data, refer [this paper](https://bradzzz.gitbooks.io/ga-seattle-dsi/dsi/dsi_05_classification_databases/2.1-lesson/assets/datasets/DefaultCreditCardClients_yeh_2009.pdf).

## Requirements

R (3.5.3)
keras (2.2.4)*
caret (6.0)
DataExplorer (0.8.0)
readxl (1.3.1)

Above requirements are my tested environment. Exact versions may not be necessary for the successful execusion of the code. Dependecy packages of above requirements are not listed.
*This Keras use Python TensorFlow (1.13.2) as backend installed in Anaconda Environment

## Data Pre-processing


## Neural Network


## To-do
1. Up sampling of data. Especially for label 1.
2. Tuning of neural network layout.
3. Experimenting with simpler algorithms, like SVM. 