freshr::freshr()
here::i_am("code/01_scatterplot.R")

# load data
coffee <- readRDS(file = here::here("data/coffee_data.RDS"))

# load packages
library(ggplot2)
library(dplyr)

# caffeine x sleep hours + regression line
figure1 <- coffee |>
  mutate(
    Alcohol_Consumption = ifelse(Alcohol_Consumption == 0, "No", "Yes")
  ) |>
  ggplot(aes(x = Caffeine_mg, y = Sleep_Hours)) +
  geom_point(size = 0.3, alpha = 0.7) +
  geom_smooth(method = "lm", se = TRUE, color = "blue") +
  labs(
    x = "Caffeine Intake (mg)",
    y = "Sleep Hours",
    title = "Average Hours of Sleep by Daily Caffeine Intake",
    subtitle = "Grouped by Alcohol Consumption"
  ) +
  facet_wrap(~Alcohol_Consumption) +
  theme_light()

# save
saveRDS(figure1, 
        file = here::here("output/scatterplot.RDS")
)
