library(ROCR)
library(ggplot2)
data(ROCR.simple)
pred <- prediction( dat$predictions, ROCR.simple$labels)
perf <- performance(pred,"tpr","fpr")
plot(perf)

dat=read.table("winnowTestResults.txt", header=T)
data.frame(dat) 


ggplot(dat,aes(dat$fpr,dat$tpr,color="red"))+geom_line(size = 1, alpha = 1)+
  labs(title= "ROC curve", 
       x = "False Positive Rate (1-Specificity)", 
       y = "True Positive Rate (Sensitivity)")
