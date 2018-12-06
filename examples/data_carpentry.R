# Examples show how to transform data into a wanted shape/representation
library(tidyverse)

# Load and cast the Titanic data set to a data frame
titanic <- datasets::Titanic %>% as.data.frame()
titanic_zero_freq <- titanic %>% 
  filter(Freq == 0) #%>% 
  #select(-Freq)

# We want to have each person as a single row => 
# we need to duplicate rows with regard to the Freq column
titanic_tidy <- titanic %>% 
  filter( Freq > 0 ) %>%              # Remove rows with zero frequency
  (function(x) x[rep(row.names(x), x$Freq), ] ) %>%  # dublicate rows
  select(-Freq) %>%                   # Drop frequency column
  `rownames<-`(NULL) %>%              # Remove row names
  #rbind(titanic_zero_freq) %>%        # dplyr::bind_rows works equally well
  `colnames<-`(tolower(colnames(.)))  # Lower case column names

# Save the data set for further use in other scripts
titanic_tidy %>% write_csv("data/tidy_titanic.csv")


# Some bonus visualisations
# Histograms
titanic_tidy %>% 
  ggplot(aes(survived, fill = class)) + 
  geom_histogram(stat = "count", position = "dodge") + 
  theme_bw()

titanic_tidy %>% 
  ggplot(aes(class, fill = survived)) + 
  geom_histogram(stat = "count", position = "dodge") + 
  theme_bw()

titanic_tidy %>% 
  ggplot(aes(class, fill = survived)) + 
  geom_histogram(stat = "count", position = "dodge") + 
  theme_bw()

titanic_tidy %>% 
  `colnames<-`(tolower(colnames(.))) %>% 
  mutate( survived = if_else(survived == "Yes", true = 1, false = 0)) %>% 
  group_by(class, sex, age) %>% 
  summarise(count = n(),
            survived = sum(survived),
            survived_perc = survived/count)








