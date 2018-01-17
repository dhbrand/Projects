setwd("/work/04734/dhbrand/stampede2/Premium/hybrid_g2f_month")
library(PReMiuM)
dat <- read.csv("../hybrid.csv", row.names = NULL, header=TRUE)
oct <- subset(dat, dat$Month==10)

numericVars <- c(grep("min",names(dat)) , grep("max",names(dat)))
dir.create("oct")
setwd(paste(getwd(),"oct", sep = "/"))
system.time({
    
    mod <- profRegr(covNames = c("temp_min","temp_max"), outcome = 'Yield',
                    yModel = 'Normal', xModel = "Mixed",
                    fixedEffectsNames = 'Yield',
                    discreteCovs = c(names(oct["Pedi"])),
                    continuousCovs = c(names(oct[c(9,10,13,14,17,18)])),
                    data = oct,
                    nSweeps = 10,
                    nBurn = 1)
})

calcDists <- calcDissimilarityMatrix(mod)

clusts <- calcOptimalClustering(calcDists,maxNClusters = 2)

riskProfileOb <- calcAvgRiskAndProfile(clusts)

clusterOrderObj<-plotRiskProfile(riskProfileOb,"oct.png")
