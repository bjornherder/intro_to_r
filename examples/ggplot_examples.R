library(tidyverse)

# dodge example
ggplot(diamonds,aes(x = "", fill = clarity)) + geom_bar(width = 1)

ggplot(diamonds,aes(x = "", fill = clarity)) + 
  geom_bar(width = 1, position = "dodge")

# boxplots
ggplot(mpg, aes(class, hwy)) + geom_boxplot()
ggplot(mpg, aes(class, hwy)) + geom_boxplot() + geom_jitter()
ggplot(mpg, aes(class, hwy)) + geom_boxplot() + coord_flip()

ggplot(mpg, aes(class, hwy)) + 
  geom_boxplot() + 
  geom_jitter(aes(alpha = 0.1)) + 
  coord_flip() + 
  theme_bw() +
  guides(alpha = FALSE)

# Polar coordinats
ggplot(diamonds,aes(x = "", fill = clarity)) + geom_bar(width = 1)
ggplot(diamonds,aes(x = "", fill = clarity)) + geom_bar(width = 1) + coord_polar (theta = "y")
ggplot(diamonds,aes(x = "", fill = clarity)) + geom_bar(width = 1) + coord_polar( theta = "x")

# Transformation of axis
ggplot(diamonds, aes(carat, price)) +
  geom_point() +
  stat_smooth(method = lm) +
  scale_x_log10() +
  scale_y_log10()

# qplot provides a fast api for ploting
qplot(carat, price, data = diamonds,
      geom = c("point", "smooth"),
      method = "lm", log = "xy"
)

# Bar charts
ggplot(diamonds,aes(x = clarity, fill=clarity)) + geom_bar()
#ggplot(diamonds,aes(x = clarity, fill=clarity)) + geom_bar(position = "dodge")
diamonds %>% 
  mutate(Clarity = clarity) %>% 
  select(-clarity) %>% 
  ggplot(aes(x = Clarity, fill= Clarity)) + geom_bar()

# Example of setting a layers properties explicitly
ggplot() +
  layer(
    data = diamonds, mapping = aes(x = carat, y = price),
    geom = "point", stat = "identity", position = "identity"
  ) +
  scale_y_continuous() +
  scale_x_continuous() +
  coord_cartesian()

## to recreate
data.frame(x = c(1,2,3,4,5) ) %>% mutate(y = exp(x)) %>% ggplot(aes(x,y)) + geom_point()
data.frame(x = c(1,2,3,4,5) ) %>% mutate(y = exp(x)) %>% ggplot(aes(x,y)) + geom_point() + geom_line()
data.frame(x = c(1,2,3,4,5) ) %>% mutate(y = exp(x)) %>% ggplot(aes(x,y)) + geom_point() + geom_line() +
   scale_y_log10()

