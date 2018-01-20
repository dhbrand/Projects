library(readr)
library(purrr)

setwd("~/Stapleton_Lab/Projects/")

system.time({
    df <- read_csv("~/Stapleton_Lab/Downloads/b._2014_gbs_data/g2f_2014_zeagbsv27v5hmp.txt", col_names = FALSE)
})

class(dat)

#need column names; 1) unlist first row of data 2) split each string on '=' 3)keep first element from each of the splits
system.time({
    a <- lapply(strsplit(unlist(dat[1,]),"="), "[", 1)
})
names(dat) <- a

# df <-lapply(strsplit(unlist(dat),"="), "[",2)
# rename first column
names(dat)[names(dat) == "##SAMPLE"] <- "Sample"
names(dat)[names(dat) == "Status"] <- "SeedLot"
# extract values in first column
dat$Sample <- lapply(strsplit(unlist(dat$Sample), "="),"[",3)

# extract values in rest of columns
system.time({
for (i in 2:21){
x <- unlist(lapply(strsplit(unlist(dat[[i]]),"="),"[",2))
dat[[i]] <- x
}
})

x <- as.list(dat)
y <- do.call(cbind,x)
z <- as.data.frame(y)

write.csv(dat, "~/Stapleton_Lab/Projects/Premium/gbs.csv")
str(dat)
