# Gabriel E. Hoffman
# Cornell University
# August 9, 2012

##################################
# R code to extract PUMA results #
##################################

# Read R file - input correct file location and name here
result = dget("results_try1_LASSO.R")

# Use AIC information criterion
criterion = "AIC"

# Evalaute the number of features selected by each model
modelSize = unlist( sapply(1:length(result), function(i){ncol(result[[i]]$features)} ) )

# Specify the sample size and apply the 1.5 sqrt(n) rule
n = 1000
index = which( modelSize < 1.5 * sqrt(n) )


# Identify model with the smallest AIC, and which satisfies the 1.5 sqrt(n) rule
j = which( names(result[[1]]$criteria) == criterion)
criteria = unlist( sapply(1:length(result), function(i){result[[i]]$criteria[j]} ) )
i = which.min( criteria[index] )

# P-values and coefficients for best model
print(result[[i]])

