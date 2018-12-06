library(tidyverse)

## Don't Repeat Yourself - DRY
## Non DRY example ----

mtcars %>% 
  mutate(kmpl = mpg * 1.609 / 3.785) %>% 
  ggplot(aes(cyl, kmpl)) + 
  geom_point(size = 5, colour = "red") + 
  theme_bw() 

mtcars %>% 
  mutate(kmpl = mpg * 1.609 / 3.785) %>% 
  ggplot(aes(hp, kmpl)) + 
  geom_point(size = 5, colour = "red") + 
  theme_bw()

mtcars %>% 
  mutate(kmpl = mpg * 1.609 / 3.785) %>% 
  ggplot(aes(disp, kmpl)) + 
  geom_point(size = 5, colour = "red") + 
  theme_bw()

mtcars %>% 
  mutate(kmpl = mpg * 1.609 / 3.785) %>% 
  ggplot(aes(gear, kmpl)) + 
  geom_point(size = 5, colour = "red") + 
  theme_bw()


## DRY ----

.point_size <- 5
.point_colour <- "red"

mtcars_kmpl <- mtcars %>% 
  mutate(kmpl = mpg * 1.609 / 3.785)

g <- mtcars_kmpl %>% ggplot() + theme_bw()

g + geom_point(aes(cyl, kmpl), size = .point_size, colour = .point_colour) 
g + geom_point(aes(gear, kmpl), size = .point_size, colour = .point_colour) 
g + geom_point(aes(hp, kmpl), size = .point_size, colour = .point_colour) 
g + geom_point(aes(disp, kmpl), size = .point_size, colour = .point_colour) 



