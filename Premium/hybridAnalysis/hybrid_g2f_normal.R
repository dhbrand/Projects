library(PReMiuM)
library(tidyverse)


setwd("~/Stapleton_Lab/Projects/Premium/hybridAnalysis/")

# read in data from analysis script
df <- read_csv("./hybrid.csv")

df %>% 
    select_if(function(x) any(is.na(x))) %>% 
    summarise_all(funs(sum(is.na(.))))


# grab month for analysis
may <- df %>% 
    filter(Month==5)
june <- df %>% 
    filter(Month==6)
july <- df %>% 
    filter(Month==7)
aug <- df %>% 
    filter(Month==8)
sept <- df %>% 
    filter(Month==9)
oct <- df %>% 
    filter(Month==10)

# check for zero variance in continuous covariates
numericVars <- grep("Min|Max",names(june))
zero <- which(lapply(june[numericVars],var)==0,useNames = TRUE)

noVar <- june %>% 
    
    select(c(grep("Min",names(may)) , grep("Max",names(may)))) %>% 
    
    summarise_all(var) 



# remove constant continous variables
june <- june[ , !(names(june) %in% names(zero))]


# limited to 15 covariates in plotRiskProfile; subsetting to only min and max weather data
numericVars <- grep("Min|Max",names(june))
numericVars <- sample(numericVars,14)

# created dataframes for each of the months to be run seperately
# datmon <- split(dat,dat$Month)
# groups <- unique(dat$Month)
# list2env(setNames(datmon,month.abb[groups]), .GlobalEnv)

system.time({
    
    mod <- profRegr(covNames, outcome = 'Yield', output = "./miscOutput/",
                    yModel = 'Normal', xModel = "Mixed",
                    discreteCovs = c(names(june["Pedi"])),
                    continuousCovs = c(names(june[numericVars])),
                    data = june,
                    nSweeps = 10,
                    nBurn = 1)
})

calcDists <- calcDissimilarityMatrix(mod)

clusts <- calcOptimalClustering(calcDists,maxNClusters = 4)

riskProfileOb <- calcAvgRiskAndProfile(clusts)

clusterOrderObj<-plotRiskProfile(riskProfileOb,"summary.png")

