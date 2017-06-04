runApp("App-1", display.mode = "showcase")


library(ROCR)
data(ROCR.simple)
pred <- prediction( dat$predictions, ROCR.simple$labels)
perf <- performance(pred,"tpr","fpr")
plot(perf)
