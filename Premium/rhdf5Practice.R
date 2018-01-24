# source("http://bioconductor.org/biocLite.R")
# biocLite("rhdf5")

library(rhdf5)
h5f <- H5Fopen("~/Stapleton_Lab/Downloads/b._2014_gbs_data/g2f_2014_zeagbsv27.imp.h5")

h5f
geno <- h5f$Genotypes
geno1 <- h5f&'Genotypes'

h5f$Positions
h5f$Taxa
h5f$__DATA_TYPES__
h5readAttributes(name = )
