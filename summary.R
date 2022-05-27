#library
library(dplyr)
library(ggplot2)
library(plotly)
library(tidyverse)
library(ggrepel)
library(lintr)
library(styler)
library(stringr)
library(usmap)

#### load data
prison_df <- read.csv("https://github.com/melaniewalsh/Neat-Datasets/blob/main/us-prison-pop.csv?raw=true",
           stringsAsFactors = FALSE)

# rows and columns
nrow(prison_df)
ncol(prison_df)

### E1,Find the state with the highest ratio of Black to White female prison population
state_highest_female_prison_ratio <- prison_df %>%
  select(state, black_female_prison_pop, white_female_prison_pop) %>%
  group_by(state) %>%
  summarise(black_female_prison_pop = sum(black_female_prison_pop, na.rm = TRUE),
            white_female_prison_pop = sum(white_female_prison_pop, na.rm = TRUE)) %>%
  mutate(rate = white_female_prison_pop / black_female_prison_pop) %>%
  filter(rate == max(rate, na.rm = TRUE)) %>%
  pull(state)

### filtered female prison population
filtered_female_prison_pop_df <- prison_df %>%
  filter(female_prison_pop != "NA")

### E2,Which state has the highest total female prison population in 2018?
state_highest_female_prison_total <- filtered_female_prison_pop_df %>%
  filter(year == max(year)) %>%
  filter(female_prison_pop == max(female_prison_pop)) %>%
  pull(state)
view(state_highest_female_prison_total)

###filtered black female prison population
filtered_black_female_prison_pop_df <- prison_df %>%
  filter(black_female_prison_pop != "NA")

### E3, Which state has the highest total Black female prison population in 2018?
state_highest_black_female_prison_total <-
  filtered_black_female_prison_pop_df %>%
  filter(year == max(year)) %>%
  filter(black_female_prison_pop == max(black_female_prison_pop)) %>%
  pull(state)

### E4,Which year has the highest total female prison population?
highest_year_prison <- filtered_female_prison_pop_df %>%
  filter(female_prison_pop == max(female_prison_pop)) %>%
  pull(year)

### E5, Average Black female prison population throughout the years
avg_black_female_prison_pop <- filtered_female_prison_pop_df %>%
  group_by(year) %>%
  summarise(black_female_prison_pop = mean(black_female_prison_pop, na.rm = TRUE))