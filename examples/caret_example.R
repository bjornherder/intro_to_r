library(tidyverse)
library(readr)
library(lubridate)
library(caret)

source("./R/util.R")
training <- read_csv("./data/train_split.csv")

# Start cluster/ parallel backend
.cores <- parallel::detectCores()
cl <- parallel::makeCluster(.cores - 2 )
doParallel::registerDoParallel(cl)

.fitControl <- trainControl(
  method = "repeatedcv",
  selectionFunction = "oneSE",
  #classProbs = TRUE,
  number = 5,
  repeats = 5,
  allowParallel = TRUE)

# Uses non-formula training api as random forest implementation in randomForest package
# can handle factors (does not create dummy variables before training)

tune_call <- list()
tune_call$trControl <- .fitControl
tune_call$metric <- "Kappa"

formula_call <- list()
formula_call$form <- as.formula("Species ~ .")
formula_call$data <- training

non_formula_call <- list()
non_formula_call$x <- training %>% select(-Species) %>% data.frame()
non_formula_call$y <- training[["Species"]]

pls_call <-list()
pls_call$method <- "pls"
pls_call$tuneGrid <- expand.grid(ncomp = seq(1, 4 , by = 2))

rf_call <- list()
rf_call$method <- "rf"
rf_call$tuneGrid <- expand.grid(mtry = seq(2, 4 , by = 1))
rf_call$ntree <- 500

lda_call <- list()
lda_call$method <- "lda"

knn_call <- list(
  method = "knn",
  tuneGrid = expand.grid(k = seq(1, 20 , by = 1))
)

xgbTree_call <- list()
xgbTree_call$method <- "xgbTree"
xgbTree_call$tuneGrid <- expand.grid(
  nrounds = c(100),
  max_depth = seq(2, 4, by = 2),
  eta = c(0.01, 0.0001),
  colsample_bytree = 0.8,
  min_child_weight = c(10, 30),
  gamma = c(0, 0.1),
  subsample = c(1)
)

# Function for calling caret training
caret_train <- function(train_call){ do.call(train, train_call) }

# Training the models on selected data  
res_list <- list()

#res_list[["xgbTree"]]  <- c(formula_call, xgbTree_call, tune_call) %>% caret_train()
res_list[["rf"]]        <- c(non_formula_call, rf_call, tune_call) %>% caret_train()
res_list[["simpls"]]    <- c(formula_call, pls_call, tune_call) %>% caret_train()
res_list[["lda"]]       <- c(formula_call, lda_call, tune_call) %>% caret_train()
res_list[["knn"]]       <- c(formula_call, knn_call, tune_call) %>% caret_train()

#save(list = c("res_list"), 
#     file = paste0("./results/", "caret_example" ,format(Sys.time(), "%d%H%M%S") ,".RData") )

# Stop cluster
parallel::stopCluster(cl)

for (model in res_list) {
  model$method %>% print
  model$results %>% print
}

# Visualise crossvalidation metrics

source("./R/plot_funcs.R")

.colors <- get_scania_colors()

# knn
res_list$knn$results %>% 
  ggplot(aes(k, Kappa), color = .colors$scania_blue) + 
  geom_errorbar(aes(x = k, ymin = Kappa + KappaSD, ymax = Kappa - KappaSD)) + 
  geom_point() + 
  theme_bw() +
  ylim(0,1) +
  ggtitle(res_list$knn$method)

# rf
res_list$rf$results %>% 
  ggplot(aes(mtry, Kappa), color = .colors$scania_blue) + 
  geom_errorbar(aes(x = mtry, ymin = Kappa + KappaSD, ymax = Kappa - KappaSD)) + 
  geom_point() + 
  theme_bw() +
  ylim(0,1) +
  ggtitle(res_list$rf$method)

# pls
res_list$simpls$results %>% 
  ggplot(aes(ncomp, Kappa), color = .colors$scania_blue) + 
  geom_errorbar(aes(x = ncomp, ymin = Kappa + KappaSD, ymax = Kappa - KappaSD)) + 
  geom_point() + 
  theme_bw() +
  ylim(0,1) +
  ggtitle(res_list$ncomp$method)



