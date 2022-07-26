#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(readr)
citibike_tripdata <- read_csv("https://firebasestorage.googleapis.com/v0/b/citibike-melissa-barrera.appspot.com/o/Bikes%2Fcitibike-tripdata.csv?alt=media&token=14d1c221-049c-4b5f-81e7-91dcd9213c6c")

dfDateStart <- as.Date(citibike_tripdata$started_at)
dfDateEnd <- as.Date(citibike_tripdata$ended_at)

plot(dfDateStart, dfDateEnd)

library(tidyr)
library(dplyr)
library(knitr)

citibike_tripdata %>% 
  drop_na %>%
  group_by(start_station_id) %>%
  summarize(
    count = n(),
    percent = count / nrow(.) * 100
  ) %>%
  arrange(desc(count), desc(start_station_id)) %>%
  head(10) %>%
  kable

citibike_member <- citibike_tripdata %>% filter(member_casual == "member")
head(citibike_member)

ggplot(citibike_tripdata, aes(x=as.factor(citibike_tripdata$rideable_type), fill=as.factor(citibike_tripdata$rideable_type) )) + 
  geom_bar( ) +
  scale_fill_hue(c = 40) +
  theme(legend.position="none")

ggplot(citibike_tripdata, aes(x=as.factor(citibike_tripdata$member_casual), fill=as.factor(citibike_tripdata$member_casual) )) + 
  geom_bar( ) +
  scale_fill_brewer(palette = "Set1") +
  theme(legend.position="none")
