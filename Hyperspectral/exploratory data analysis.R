dat=read.csv("headers3mgperml.csv", header=TRUE)

hist(dat$Kernelwt)

boxplot(dat[2:15])

plot(dat[16:25])
        