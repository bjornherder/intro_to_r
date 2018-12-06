library(tidyverse)
library(caret)

set.seed(42)

dataset <- iris %>% as.tibble()

# Split into training (cross-validation) and test set 80-20
# with balanced class distributions within splits

.create_train_test_split <- function(dataset, y = "y"){
  train_index <- createDataPartition(dataset[[y]],
                                     p = .8, 
                                     list = FALSE, 
                                     times = 1)
  return(train_index)
}

# Kept simple due to course, could be combined to one function with additional argument 
.train_split <- function(dataset, index){
  dataset %>% 
    as.data.frame() %>% 
    .[index,] 
}

# Note the negative index selection in the data frame
.test_split <- function(dataset, index){
  dataset %>% 
    as.data.frame() %>% 
    .[-index,] 
}

train_index <- .create_train_test_split(dataset, y = "Species")

train_split = data_set %>% 
  as.data.frame() %>% 
  .[train_index,] 

train_split  %>%  write_csv(path = "./data/train_split.csv")

test_split = data_set %>% 
  as.data.frame() %>% 
  .[-train_index, ]

test_split %>% write_csv(path = "./data/test_split.csv")