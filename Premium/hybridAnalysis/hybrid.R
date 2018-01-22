###job script for batch submission
library(PReMiuM)

dat <- read.csv("hybrid.csv", row.names = 1,header=TRUE)


dat$Geno<-as.character(dat$Geno)
numericVars <- which(sapply(dat, class)=='numeric' & names(dat) != 'Yield')
categoricalVars <- which(sapply(dat, class)=='character' & names(dat) != 'Yield')

system.time({
    
    mod <- profRegr(covName, outcome = 'Yield', 
                    yModel = 'Normal', xModel = "Mixed",
                    #nCovariates = 2,
                    #fixedEffectsNames = 'yield',
                    discreteCovs = c(names(dat[categoricalVars])),
                    continuousCovs = c(names(dat[numericVars])),
                    data = dat)
})

calcDists <- calcDissimilarityMatrix(mod)

clusts <- calcOptimalClustering(calcDists)

riskProfileOb <- calcAvgRiskAndProfile(clusts)

clusterOrderObj<-plotRiskProfile(riskProfileOb,"summary.png")