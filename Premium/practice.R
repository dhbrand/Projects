##install.packages("PReMiuM")
library(PReMiuM)
set.seed(1234)
clusSummaryBernoulliDiscrete()$clusterSizes
clusSummaryBernoulliDiscrete()$clusterData[[1]]

inputs <- generateSampleDataFile(clusSummaryBernoulliDiscrete())
head(inputs$inputData)

runInfoObj<-profRegr(yModel=inputs$yModel, xModel=inputs$xModel, nSweeps=100, nClusInit=15,
                     nBurn=300, data=inputs$inputData, output="output", covNames = inputs$covName,
                     fixedEffectsNames = inputs$fixedEffectNames, seed=12345)
readLines("output_input.txt",15)
