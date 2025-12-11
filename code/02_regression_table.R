freshr::freshr()

here::i_am("code/02_regression_table.R")

# load data
coffee <- readRDS(file = here::here("data/coffee_data.RDS"))

# load packages 
library(lme4)
library(gtsummary)

# loaded just in case
library(broom)
library(broom.helpers)
library(car)
library(parameters)

# regression
model1 <- lm(Sleep_Hours ~ Caffeine_mg + Alcohol_Consumption, data = coffee)

table1 <- tbl_regression(model1,
                         intercept = TRUE, # show intercept
                         estimate_fun = ~style_sigfig(.x, digits = 4)) |>
  modify_caption("**Table 1. Linear Regression of Sleep Hours**") 


# save
saveRDS(model1, 
        file = here::here("output/regression_model.RDS")
)

saveRDS(table1, 
        file = here::here("output/regression_table.RDS")
)
