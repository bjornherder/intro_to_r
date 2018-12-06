library(tidyverse)

## Exercise: Rewrite the for loop using functional constructs 
char_lengths <- array(data = 0, dim =  length(lorem))

char_sum <- 0
for(i in lorem){
  char_sum <- char_sum +nchar(i)
}

## Solution using map - reduce ----
char_sum <- lorem %>% map(nchar) %>% reduce(sum)
char_sum <- lorem %>% map(function(x) nchar(x)) %>% reduce(sum) # Equivalent to above

## Solution using that R is array based ----
char_sum <- lorem %>% nchar %>% sum
char_sum <- sum(nchar(lorem)) # Equivalent to above 