library(tidyverse)

# Use "date" as x axis and "unemploy" as y axis
ggplot(economics, aes(date, unemploy)) + geom_point()
ggplot(economics, aes(x = date, y = unemploy)) + geom_point() # Equivilant
economics %>% ggplot(aes(date, unemploy)) + geom_point() # Equivilant

# Change geom
economics %>% ggplot(aes(date, unemploy)) + geom_line() 

# Use two geoms
economics %>% ggplot(aes(date, unemploy)) + geom_line()  + geom_point() 

# Order of the geoms are irrelevant
economics %>% ggplot(aes(date, unemploy)) + geom_point() + geom_line()

# Change color of geom_line
economics %>% ggplot(aes(date, unemploy)) + geom_point() + geom_line(color = "blue")

# Change the size of the geom_point 
economics %>% ggplot(aes(date, unemploy)) + geom_point(size = 1) + geom_line()

# Change shape of geom_point
economics %>% ggplot(aes(date, unemploy)) + geom_point(shape = 2) + geom_line(color = "blue")
economics %>% ggplot(aes(date, unemploy)) + geom_point(shape = 4) + geom_line(color = "blue")

# Change the background using themes
economics %>% ggplot(aes(date, unemploy)) + geom_point() + geom_line() + theme_bw()

# Change everything!
economics %>% 
  ggplot(aes(date, unemploy)) + 
  geom_point(color = "blue", shape = 2, size =3) + 
  geom_line(color = "red") + 
  theme_bw() +
  coord_flip() +
  coord_equal() +
  ggtitle("Ugly plot", subtitle = "Do better!")

### use multiple lines
economics %>% 
  ggplot() +
  geom_line(aes(date, unemploy), color = "green") +
  geom_line(aes(date, pce), color = "red") + 
  theme_bw() + 
  ggtitle("Two lines")




