library(tidyverse)

## map instead of loop
# count average word length

lorem <- read_file("input/lorem.txt") %>% strsplit(" ") %>% unlist

# for loop
tictoc::tic()
loop_sum <- 0
for (word in lorem){
  loop_sum <- loop_sum + nchar(word)
}

loop_sum/length(lorem)
tictoc::toc()
# using map
tictoc::tic()
lorem %>% map(nchar) %>% reduce(sum) %>% (function(x) x/length(lorem))
tictoc::toc()
# knowing that R uses array programing
tictoc::tic()
lorem %>% nchar %>% mean
tictoc::toc()

## https://github.com/tidyverse/purrr

mtcars %>%
  split(.$cyl) %>% # from base R
  map(~ lm(mpg ~ wt, data = .)) %>%
  map(summary) %>%
  map_dbl("r.squared")

# Step by step
mtcars

mtcars %>%
  split(.$cyl) # splits dataset into entries with the same number of cylinders

mtcars %>%
  split(.$cyl) %>% 
  map(~ lm(mpg ~ wt, data = .)) # map lists to linear model fitting

mtcars %>%
  split( .$cyl) %>% # from base R
  map(~ lm( mpg ~ wt, data = .)) %>%
  map(summary)  %>% 
  map_dbl("r.squared") # "pluck" values from the result of the previous mapping

mtcars %>%
  split( .$cyl) %>% # from base R
  map(~ lm( mpg ~ wt, data = .)) %>%
  map(summary)  %>% 
  tibble(
    r_squared = map_dbl(., "r.squared"),
    r_squared_adj = map_dbl(., "adj.r.squared")
  ) %>% 
  select(-`.`) # negative selection to remove first column



