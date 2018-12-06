# Examples show how to transform data into a wanted shape/representation
library(tidyverse)

# Load and cast the Titanic data set to a data frame
titanic <- datasets::Titanic %>% as.data.frame()