library(ROCR)
library(ggplot2)

##install themes for shinyapp from bootswatch
install.packages("shinythemes")

data(ROCR.simple)
pred <- prediction( dat$predictions, ROCR.simple$labels)
perf <- performance(pred,"tpr","fpr")
plot(perf)

dat=read.table("winnowTestResults.txt", header=T)
dat2=read.table("Syn03Winnow2.txt", header=T)
print(str(dat))

plot(dat$accuracy,dat$error)
lines(dat$accuracy,dat$error)
str(dat)
data.frame(dat) 
library(MINOTAUR)
MINOTAUR()
ggplot(dat,aes(dat$fpr,dat$tpr,color="red"))+geom_line(size = 1, alpha = 1)+
  labs(title= "ROC curve", 
       x = "False Positive Rate (1-Specificity)", 
       y = "True Positive Rate (Sensitivity)")

##loading xtable to renderTable function using data frame
install.packages("xtable")
library(xtable)
dat.table=xtable(dat)

install.packages('rsconnect')
rsconnect::setAccountInfo(name='dhbrand',
                          token='16CA732EDC8A8D27B1219F9F8F1E394F',
                          secret='<SECRET>')
rsconnect::setAccountInfo(name='dhbrand',
                          token='16CA732EDC8A8D27B1219F9F8F1E394F',
                          secret='u17gUfsPXdLfN84PpMIlA/Y5UHloLjA4SVF1WUnd')
library(rsconnect)
rsconnect::deployApp('/tooltip-ggplot2-app')
