library(tidyverse)
library(PReMiuM)

setwd("~/Stapleton_Lab/Projects/Premium/inbredAnalysis/")

df <- read_csv("inbred.csv")

numericVars <- c(grep("Min",names(df)) , grep("Max",names(df)))
set.seed(123)
weatherVars <- sample(numericVars,12)

system.time({
    profRegr(covNames, outcome = "plantHt", data = df, nSweeps = 10, nBurn = 1,
             seed = 123, yModel = "Normal", xModel = "Mixed", discreteCovs = c("Pedi", "Repl"),
             continuousCovs = names(df[weatherVars]), output = "./plantHtDayMinMaxOutput/")
})
