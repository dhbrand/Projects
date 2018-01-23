library(tidyverse)

setwd("~/Stapleton_Lab/Projects/Premium/hybridAnalysis/")

# read the raw data
hyb <-  read_csv("~/Stapleton_Lab/Downloads/Carolyn_Lawrence_Dill_G2F_Mar_2017/a._2015_hybrid_phenotypic_data/g2f_2015_hybrid_data_no_outliers.csv")

# tidy the data
hyb1 <- hyb %>% 
    
    select(Exp = "Field-Location", Pedi = "Pedigree", Repl = Replicate, Harvest = "Date Harvested",
           plantHt = "Plant height [cm]", earHt = "Ear height [cm]", testWt = "Test weight [lbs]",
           plotWt = "Plot Weight [lbs]", Yield = "Grain yield [bu/acre]") %>% 
    
    arrange(Exp, Pedi, Repl)

##need experiment numbers for wthdat
hybrid <- right_join(hyb1, wth2, by = "Exp") %>% 
    
    drop_na()

hybrid %>% 
    select_if(function(x) any(is.na(x))) %>% 
    summarise_all(funs(sum(is.na(.))))
##make csv for batch submission script

write_csv(hybrid, "./hybrid.csv")


apply(hybrid, 2, function(x) any(is.na(x)))
