library(dplyr)
library(ggplot2)
library(plotly)
library(tidyverse)
prison_df <- read.csv("https://github.com/melaniewalsh/Neat-Datasets/blob/main/us-prison-pop.csv?raw=true",
                      stringsAsFactors = FALSE)

female_prison_pop <- prison_df %>%
  group_by(year) %>%
  filter(year == max(year)) %>%
  filter(black_female_prison_pop == black_female_prison_pop) %>%
  filter(aapi_female_prison_pop == aapi_female_prison_pop) %>%
  filter(white_female_prison_pop == white_female_prison_pop) %>%
  filter(native_female_prison_pop == native_female_prison_pop) %>%
  filter(latinx_female_prison_pop == latinx_female_prison_pop) %>%
  summarize(black_female_prison_pop = sum(black_female_prison_pop),
            aapi_female_prison_pop = sum(aapi_female_prison_pop),
            white_female_prison_pop = sum(white_female_prison_pop),
            native_female_prison_pop = sum(native_female_prison_pop),
            latinx_female_prison_pop = sum(latinx_female_prison_pop),
            female_prison_total = sum(female_prison_pop))

###
line_chart2 <- ggplot(data = female_prison_pop) +
  geom_line(mapping = aes(x = year,
                          y = black_female_prison_pop, color = "black")) +
  geom_line(mapping = aes(x = year,
                          y = aapi_female_prison_pop, color = "orange")) +
  geom_line(mapping = aes(x = year,
                          y = white_female_prison_pop, color = "blue")) +
  geom_line(mapping = aes(x = year,
                          y = native_female_prison_pop, color = "red")) +
  geom_line(mapping = aes(x = year,
                          y = latinx_female_prison_pop, color = "purple")) +
  scale_color_manual(
    name = "Races:",
    values = c("black", "blue", "orange", "purple", "red"),
    labels = c("Black", "White", "AAPI", "Latin", "Native")
    ) +
  ggtitle("Demographic of Female Prison Population in Washington State Throughout the Years") +
  labs(x = "year", y = "Number of Female Prison Population")

line_chart2
