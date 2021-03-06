# imports all the packages i'll need
library(tidyverse)

setwd("~/Stapleton_Lab/Projects/Premium/hybridAnalysis/")

# read the raw data as a tibble/data.frame
hyb <-  read_csv("~/Stapleton_Lab/Downloads/Carolyn_Lawrence_Dill_G2F_Mar_2017/a._2015_hybrid_phenotypic_data/g2f_2015_hybrid_data_no_outliers.csv")

# tidy the data
hyb1 <- hyb %>% 
    
    # choosing variables to keep and renaming
    select(Exp = "Field-Location", Pedi = "Pedigree", Repl = Replicate, Harvest = "Date Harvested",
           plantHt = "Plant height [cm]", earHt = "Ear height [cm]", testWt = "Test weight [lbs]",
           plotWt = "Plot Weight [lbs]", Yield = "Grain yield [bu/acre]") %>% 
    
    # changing the sort 
    arrange(Exp, Pedi, Repl)

# joining the tidy weather data with min/max variables
# right join to preserve weather data and fill matching hybrid data to each expermient
hybrid <- right_join(hyb1, wth2, by = "Exp") %>%  
    
    drop_na()

# check for NA's
hybrid %>% 
    select_if(function(x) any(is.na(x))) %>% 
    summarise_all(funs(sum(is.na(.))))

# write the data to csv
write_csv(hybrid, "./hybrid.csv")



