library(tidyverse)

## Some examples using the apply family of commands

?apply # A question mark before a command shows the help in RStudio
?lapply

## Example 1): sorting values ----

nbrs <- data.frame(ints = sample.int(10), 
                   dbls = runif(10))
nbrs

# Sorts each column, i.e. applies the function to the column (MARGIN = 1 applies to rows)
apply(nbrs, 2, sort) 

# this is in contrast to ordering the data frame based on one columns as 
nbrs[order( nbrs$ints ), ] 
nbrs[order( nbrs$dbls ), ] 

## Example 2) function apply to list using lapply (list apply) ----

text_list <- read_file("data/lorem.txt") %>% 
  strsplit(split = " ")
text_list 

lapply(text_list, toupper ) # applies the "toupper" function to all elements in the list

## Example 3) sapply is like lapply but with a different return format----

sapply(text_list, toupper )
