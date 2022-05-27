library(dplyr)
library(knitr)
prison_df <- read.csv("https://github.com/melaniewalsh/Neat-Datasets/blob/main/us-prison-pop.csv?raw=true",
                      stringsAsFactors = FALSE)
filtered_female_prison_pop_df <- prison_df %>%
  filter(female_prison_pop != "NA")
# Gathering just the groups of occupations
avg_black_female_prison_pop <- filtered_female_prison_pop_df %>%
  group_by(year) %>%
  summarise(black_female_prison_pop = mean(black_female_prison_pop, na.rm = TRUE))
# Makes the table for the Industries for the occupations.
kable(avg_black_female_prison_pop)