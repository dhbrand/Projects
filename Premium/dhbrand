####Will be used to benchmark Premium performance across multiple nodes on Stampede2

library(PReMiuM)
require(snow)

##clusSummaryNormalDiscrete chosen because it has the largest popSize
inputs <- generateSampleDataFile(clusSummaryNormalDiscrete())

ptm <- proc.time()
runInfoObj<-profRegr(yModel=inputs$yModel, xModel=inputs$xModel, nSweeps=100000, nClusInit=15, nBurn=20000, 
                     data=inputs$inputData, output="output", covNames = inputs$covName, fixedEffectsNames = inputs$fixedEffectNames, seed=12345)
print(proc.time() - ptm)

