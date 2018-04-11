rm(list=ls())
library("EBEN")
library(foreach)
library(iterators)
library(parallel)
library(parEBEN)
library(readr)
library(dplyr)

phenotype <- read_delim("pheno1", "\t", col_names = c("y"))
genotype <- read_delim("filter_matrix","\t", col_names = c("SAMID",paste0("x",seq(1:5356))))
#tests <- read_csv("test_time_3-8-2018_gaussian.csv")


## Register your local cluster.
library(doParallel)
no_cores <- detectCores()
#cl <- makeCluster(no_cores-1, outfile="Log.txt")
cl <- makeCluster(no_cores)
#clusterExport(cl, c("parEBEN.cv.doParallel"))
registerDoParallel(cl)
#stopImplicitCluster()

output <- CrossValidate(as.matrix(genotype[,2:ncol(genotype)]), phenotype$y, nFolds = 3, Epis = "no", prior = "gaussian")

########################################
n <- 500
k <- 250
nFolds <- 3
BASIS <- as.matrix(genotype[1:n,1:k])
y  <- as.matrix(phenotype$y[1:n])

output <- CrossValidate(BASIS, y, nFolds, Epis = "no", prior = "gaussian")

for (i in 1:nrow(tests)){
  n <- tests[i,1]
  k <- tests[i,2]
  nFolds <- tests[i,3]
  set.seed(1)
  BASIS <- as.matrix(genotype[1:n,1:k])
  y  <- as.matrix(phenotype$y[1:n])
  cat("Iteration:",i ," (n:", n,"k:", k,"nFolds:", nFolds,")\n")
  sertime <- system.time(EBelasticNet.GaussianCV(BASIS, y, nFolds, Epis = "no"))
  tests[i,4] <- sertime[1]
  tests[i,5] <- sertime[2]
  tests[i,6] <- sertime[3]
  partime <- system.time(parEBEN.cv(BASIS, y, nFolds, Epis = "yes", parMethod = "doParallel", prior = "gaussian"))
  tests[i,7] <- partime[1]
  tests[i,8] <- partime[2]
  tests[i,9] <- partime[3]
}
write.csv(tests,"testoutput_time_3-8-2018_gaussian.csv")

