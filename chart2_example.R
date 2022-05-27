library(dplyr)
library(ggplot2)
library(plotly)
library(tidyverse)

#scatterplot
washington <- prison_df %>%
  group_by(year) %>%
  filter(state == "WA") %>%
  filter(female_prison_pop == female_prison_pop) %>%
  summarise(female_prison_pop = sum(female_prison_pop))

scatterplot <- ggplot(washington, aes(x = year, y = female_prison_pop)) +
  geom_point() +
  labs(x = "year", y = "Female Prison Population") +
  ggtitle("Female Prison Population in Washington State Throughout the Years")

scatterplot
