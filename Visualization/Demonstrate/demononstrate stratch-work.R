##install.packages("DemoMPlot.tar.gz",repos=NULL, type="source")

R.Version()

library(plyr)
library(ggplot2)
library(DemoMPlot)



Demonstrate("~/Stapleton_Lab/Projects/Visualization/Demonstrate/Winnow Results", outputdir=NULL, settingsfile=NULL, make.AUC.plot=TRUE, AUC.plot.title="Mean AUC By Population Structure and Heritability", make.MAE.plot=TRUE, MAE.plot.title="Mean MAE By Population Structure and Heritability",herit.strings=list("_03_","_04_","_06_"),herit.values=list(0.3,0.4,0.6),struct.strings=list("PheHasStruct","PheNPStruct"),struct.values=list(TRUE,FALSE))

Demonstrate("~/Stapleton_Lab/Projects/Visualization/Demonstrate/Winnow Results", outputdir=NULL, settingsfile=NULL, make.AUC.plot=TRUE, AUC.plot.title="Mean AUC By Population Structure and Heritability", make.MAE.plot=TRUE, MAE.plot.title="Mean MAE By Population Structure and Heritability")

MPlot("~/Stapleton_Lab/Projects/Visualization/Demonstrate/Winnow Results")

Demonstrate2("~/Stapleton_Lab/Projects/Visualization/Demonstrate/Winnow Results", make.pos.plot=TRUE, pos.plot.title="True Positives by False Positives",
                       make.error.plot=TRUE, error.plot.title="Plot of AUC by MAE", extra.plots=TRUE, 
                       AUC.axis.min=0, AUC.axis.max=1.0, MAE.axis.min=0, MAE.axis.max=2.0)
