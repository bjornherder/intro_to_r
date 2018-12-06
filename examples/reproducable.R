## Setting the sedd  will make sure that the results will be reproducable as it sets the state for random number generation
## However, do not set the seed at multiple places if unsure of what you are doing

.seed <- 42

set.seed(.seed)
sample(1:10,3)

set.seed(.seed)
sample(1:10,3)

set.seed(.seed)
runif(n = 10, min = 1, max = 100)
set.seed(.seed)
runif(n = 10, min = 1, max = 100)

## When dividing data into different sets (such as training, validation, test etc.) a seed is useful
# http://topepo.github.io/caret/data-splitting.html
set.seed(.seed)
trainIndex <- caret::createDataPartition(iris$Species, p = .8, 
                                  list = FALSE, 
                                  times = 1)
