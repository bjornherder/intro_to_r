# Lubridate example
library(tidyverse)
library(lubridate)

# Create range of dates
dates <- seq.Date(from = as_date("2016-07-04"), to = as_date("2018-01-19"), by = "day")

# Some functions 
dates %>% isoyear %>% unique

# One way to compute time in seconds 
dates %>% 
  (function(x) list(min_time = as.POSIXct(as.Date(min(x))), max_time = as.POSIXct(as.Date(max(x))) )) %>%   
  (function(x) difftime(time1 = x$max_time, time2 = x$min_time, units = "secs"))

# Another way
tibble(dates = dates) %>% 
  group_by() %>% 
  summarise(min_time = min(dates),
            max_time = max(dates)) %>% 
  mutate_all(function(x) as.POSIXct(x)) %>% 
  (function(x) difftime(time1 = x$max_time, 
                        time2 = x$min_time, 
                        units = "secs") ) 

# Same as above with weeks
tibble(dates = dates) %>% 
  group_by() %>% 
  summarise(min_time = min(dates),
            max_time = max(dates)) %>% 
  mutate_all(function(x) as.POSIXct(x)) %>% 
  (function(x) difftime(time1 = x$max_time, 
                        time2 = x$min_time, 
                        units = "weeks") ) 

# Get weekdays from dates
tibble(dates = dates) %>% 
  mutate(weekday1 = wday(dates),
         weekday2 = wday(dates, label = TRUE),
         weekday3 = wday(dates, label = TRUE, abbr = FALSE))

# Days in month
dates[c(1, 70, 100)] %>% days_in_month()
  

  




