setwd("~/Stapleton_Lab/Projects/Premium/R work/")

##install.packages("PReMiuM")
library(PReMiuM)
set.seed(1234)

clusSummaryBernoulliDiscrete()$clusterSizes <- c(300,100,500,400,200)
clusSummaryBernoulliDiscrete()$clusterData[[1]]
##why are there 3 levels for the 5 covariate probabilites
##$covariateProbs

##the beta coefficients for the model
clusSummaryBernoulliDiscrete()$fixedEffectsCoeffs

clusSummaryBernoulliDiscrete()$missingDataProb


inputs <- generateSampleDataFile(clusSummaryNormalDiscrete())
head(inputs$inputData)

inputs$covNames
inputs$xModel
inputs$yModel
inputs$nCovariates
inputs$fixedEffectNames


ptm <- proc.time()
runInfoObj<-profRegr(yModel=inputs$yModel, xModel=inputs$xModel, nSweeps=1000, nClusInit=15, nBurn=200, 
                     data=inputs$inputData, output="output", covNames = inputs$covName, fixedEffectsNames = inputs$fixedEffectNames, seed=12345)
proc.time() - ptm


##clusterCall(cl, eval, myfunc(arg1,arg2,...))
require(snow)

hostnames <- rep('localhost', 8)
cluster <- makeSOCKcluster(hostnames)

##mclusterExport(cluster, list('mod'))

ptm <- proc.time()
result <- clusterCall(cluster, eval, profRegr(yModel=inputs$yModel, xModel=inputs$xModel, nSweeps=10000, nClusInit=15, nBurn=20000, 
                                              data=inputs$inputData, output="output", covNames = inputs$covName, fixedEffectsNames = inputs$fixedEffectNames, seed=12345))
proc.time() - ptm

stopCluster(cluster)

readLines("output_input.txt",15)
nClustersSweep1<-read.table("output_nClusters.txt")[1,1]
nClustersSweep1

as.numeric(strsplit(readLines("output_nMembers.txt",1)," ")[[1]])
readLines("output_log.txt")

perfcomp <- data.frame
