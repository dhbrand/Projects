setwd("~/Stapleton_Lab/Projects/Premium/inbredAnalysis/")

library(tidyverse)

# read the raw data
ib <- read_csv("~/Stapleton_Lab/Downloads/Carolyn_Lawrence_Dill_G2F_Mar_2017/d._2015_inbred_phenotypic_data/g2f_2015_inbred_raw_data.csv", col_names = TRUE)

# tidy the data
ib1 <- ib %>% 
    select(Exp = "Field-Location", Pedi = "Pedigree", Repl = Replicate, plantHt = "Plant Height [cm]", 
              earHt = "Ear Height [cm]") %>% 
    arrange(Exp, Pedi, Repl)


# joining the tidy weather data with min/max variables
inbred <- right_join(ib1, wth2, by = "Exp") %>% 
    drop_na()

# write the data
write_csv(inbred, "./inbred.csv")
