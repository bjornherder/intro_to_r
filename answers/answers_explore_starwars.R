library(tidyverse)

# From the Star Sars data set, find the "person" with

# 1) The oldest 
# 2) The highest mass to height ratio
# 3) Who have starred in the most movies
# 4) Has the longest name
# 5) Is the shortest

# 1) Jabba Desilijic Tiure
starwars %>% 
  mutate(mass_height_ratio = mass/height) %>% 
  arrange(desc(mass_height_ratio)) %>% 
  select(name) %>% 
  .[1,1]

# 2) Wicket Systri Warrick 
starwars %>% 
  arrange(birth_year) %>% 
  select(name, birth_year)

# 3) R2-D2 
starwars %>% 
  mutate(n_movies = lengths(films)) %>% 
  arrange(desc(n_movies)) %>% 
  select(name, n_movies)

# 4) Tied between Jabba Desilijic Tiure and Wicket Systri Warrick
starwars %>% 
  select(name) %>% 
  mutate(nchar = nchar(name)) %>% 
  arrange(desc(nchar))

# 5) Yoda
starwars %>% 
  arrange(height)
