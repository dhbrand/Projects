devtools::install_github("End-to-end-provenance/RDataTracker")
library(RDataTracker)

setwd("~/Stapleton_Lab/Projects/Premium/dataProvenance")

ddg.run("eeProvCalculateSquare.R", display=TRUE)

ddg.run("hybridWrangle.R", display = TRUE)
