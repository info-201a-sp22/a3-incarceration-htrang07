library(usmap)
library(dplyr)
library(ggplot2)
library(plotly)

filtered_df_plot <- prison_df %>% 
  filter(female_prison_pop != "NA" & total_pop !="NA")

female_pop <- filtered_df_plot %>% 
  group_by(state) %>% 
  filter(year == max(year, na.rm = TRUE)) %>% 
  filter(female_prison_pop == female_prison_pop) %>% 
  filter(total_pop == total_pop) %>% 
  mutate(total_pop / female_prison_pop) %>% 
  summarize(pop = sum(female_prison_pop, na.rm = TRUE), total = max(total_pop, na.rm = TRUE), mutate = sum(total_pop / female_prison_pop))

### Theme 
blank_theme <- theme_bw() +
  theme(
    axis.line = element_blank(),
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    axis.title = element_blank(),
    plot.background = element_blank(),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    panel.border = element_blank(),
  )

map <- plot_usmap(
  data = female_pop, values = "pop", color = "black",
  name = "Female Population"
) +
  coord_fixed(1) +
  blank_theme +
  scale_fill_gradientn(
    colours = c("white", "red"),
    breaks = c(0, 10, 100, 1000, 10000),
    trans = "log10", name = "Female Population"
  ) +
  labs(title = "Choropleth Map of Female Prison Population in 2018", subtitle = "United States", name = "Female Prison Population") +
  theme(legend.position = "right")

map



  