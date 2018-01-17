# job script for batch submission

setwd("~/Stapleton_Lab/Projects/Premium/R work/")
library(PReMiuM)
library(grid)
library(ggplot2)
#library(dplyr)
dat <- read.csv("../hybrid.csv", row.names = NULL, header=TRUE)
#dat[dat==0] <- 1
# changing variables for input into premium
# dat$Pedi<-as.character(dat$Pedi)

# subsetting for only min max cov's
numericVars <- c(grep("min",names(dat)) , grep("max",names(dat)))
#numericVars <- which(sapply(dat, class)=='numeric' & names(dat) != 'Yield')
# categoricalVars <- which(sapply(dat, class)=='character' & names(dat) != 'Yield')

# subsetting by month
# months <- sort(unique(dat$Month))
#  months  3  4  5  6  7  8  9 10 11 12
# checking performance
# system.time(mar <- dat %>% filter(dat$Month == 3))
#  user  system elapsed 
# 0.007   0.000   0.006

system.time(mar <- subset(dat, dat$Month==3))
#  user  system elapsed 
# 0.003   0.001   0.004 
# subset twice the speed for data size


# monname <- as.character(month.abb)
# for (i in monname) {
#     i <- subset(dat,dat$Month==i)
#     monname[i] <- i
# }
# 
# for (mon in monname) {
#     a <- dplyr::filter(dat, Month == mon)
#     print(a)
# }

aprl <- subset(dat,dat$Month==4)
may <- subset(dat, dat$Month==5)
june <- subset(dat, dat$Month==6)
july <- subset(dat, dat$Month==7)
aug <- subset(dat, dat$Month==8)
sept <- subset(dat, dat$Month==9)
oct <- subset(dat, dat$Month==10)
nov <- subset(dat, dat$Month==11)
dec <- subset(dat, dat$Month==12)

system.time({
    
    mod <- profRegr(covNames = c("temp_min","temp_max"), outcome = 'Yield',
                    yModel = 'Normal', xModel = "Mixed",
                    fixedEffectsNames = 'Yield',
                    discreteCovs = c(names(june["Pedi"])),
                    continuousCovs = c(names(june[c(21,22,25,26,29,30,33,34)])),
                    data = june,
                    nSweeps = 10,
                    nBurn = 1)
})

calcDists <- calcDissimilarityMatrix(mod)

clusts <- calcOptimalClustering(calcDists,maxNClusters = 4)

riskProfileOb <- calcAvgRiskAndProfile(clusts)

clusterOrderObj<-plotRiskProfile(riskProfileOb,"summary.png")

