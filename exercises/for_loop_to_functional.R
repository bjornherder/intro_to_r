library(tidyverse)
lorem <- read_file("data/lorem.txt") %>% strsplit(" ") %>% unlist

## Exercise: Rewrite the for loop using functional constructs
## In the loop the number of characters for each of the word in the lorem list is counted
## and the count in then summed to the char_sum variable

char_sum <- 0

for (i in 1:length(lorem)){
  char_sum <- char_sum + nchar(lorem(i))
}

# Note that above can also, like in python, be iterated over like
char_sum <- 0
for(i in lorem){
  char_sum <- char_sum +nchar(i)
}
