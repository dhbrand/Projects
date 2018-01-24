library(PReMiuM)
library(tidyverse)


setwd("~/Stapleton_Lab/Projects/Premium/hybridAnalysis/")

# read in data from analysis script
df <- read_csv("./hybrid.csv")

# checking for missing variable
# df %>% 
#     select_if(function(x) any(is.na(x))) %>% 
    # summarise_all(funs(sum(is.na(.))))


# grab month for analysis
# may <- df %>% 
#     filter(Month==5)
# june <- df %>% 
#     filter(Month==6)
# july <- df %>% 
#     filter(Month==7)
# aug <- df %>% 
#     filter(Month==8)
# sept <- df %>% 
#     filter(Month==9)
# oct <- df %>% 
#     filter(Month==10)

args <- commandArgs()

g <- function(mon){
    temp <- df %>% filter(Month==mon) 
    # month <- assign(paste(month.name[mon]),temp)

        f <- function(x){
            
            # find continous variables with variance and return as numericVars
            val <- grep("Min|Max",names(temp))
            numericVars <- names(temp[val])[vapply(temp[val], function(x) var(x) != 0, logical(1))]
        
            # limited to 15 covariates in plotRiskProfile; subsetting to only min and max weather data
            numericVars <- sample(numericVars,14)
            
            # create directory and change to working directory
            dir.create(paste(month.name[mon]))
            setwd(paste(getwd(),month.name[mon], sep = "/"))
        
            mod <- profRegr(covNames, outcome = 'Yield',
                            yModel = 'Normal', xModel = "Mixed",
                            discreteCovs = "Pedi",
                            continuousCovs = numericVars,
                            data = temp,
                            nSweeps = 10,
                            nBurn = 1)
        
        
            calcDists <- calcDissimilarityMatrix(mod)
            
            clusts <- calcOptimalClustering(calcDists,maxNClusters = 2)
            
            riskProfileOb <- calcAvgRiskAndProfile(clusts)
            
            clusterOrderObj<-plotRiskProfile(riskProfileOb,paste(month.name[mon],".png",sep = ""))
            
        }
        
        f(mon)

}
g(args[6])
