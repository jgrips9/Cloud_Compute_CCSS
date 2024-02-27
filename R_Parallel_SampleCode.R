
#Use these
#More complex example
#Install.packages("parallel")
#Install.packages("doParallel")
library(parallel)
library(doParallel)
## choose number of processors/cores to run in parallel
cl <- makeCluster(4)
registerDoParallel(cl)
x <- iris[which(iris[,5] != "setosa"), c(1,5)]
trials <- 50000
#Parallel time
ptime1 <- system.time({
r <- foreach(icount(trials), .combine=cbind) %dopar% {
ind <- sample(300, 300, replace=TRUE)
result1 <- glm(x[ind,2]~x[ind,1], family=binomial(logit))
coefficients(result1)
  }
})
stopCluster(cl)

stime1 <- system.time({
  r <- foreach(icount(trials), .combine=cbind) %do% {
    ind <- sample(300, 300, replace=TRUE)
    result1 <- glm(x[ind,2]~x[ind,1], family=binomial(logit))
    coefficients(result1)
  }
})
