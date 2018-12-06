library(tidyverse)
library(parallel)

# Start cluster/ parallel backend
.cores <- parallel::detectCores()
cl <- parallel::makeCluster( .cores - 4 )
doParallel::registerDoParallel(cl)

# Monte carlo integration
# Inspired by
# https://stackoverflow.com/questions/13400559/monte-carlo-integration-in-r

f = function(x) x^5 + x^3 + exp(x) + 1   
N = 1e6

monte_carlo_integration <- function(f, N){
  sum(f(runif(N, -2, 2)) > runif(N, 0, 6))/N * (4*6)
}

clusterExport(cl, "monte_carlo_integration") # export function to cluster workers

arg_list <- list(f = f, N = N) 

large_list <- list(arg_list) %>% rep(100)

# Non-parallel
tictoc::tic()
lapply(large_list, function(x) do.call(monte_carlo_integration, x)) %>% reduce(c)
tictoc::toc()

# Parallelized
tictoc::tic()
parLapply(cl = cl, X = large_list, fun = function(x) do.call(monte_carlo_integration, x)) %>% reduce(c)
tictoc::toc()

parallel::stopCluster(cl)
