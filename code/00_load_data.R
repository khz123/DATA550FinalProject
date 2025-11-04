here::i_am("code/00_load_data.R")

# load
coffee <- read.csv(file = here::here("data/synthetic_coffee_health_10000.csv"))

# save
saveRDS(coffee, 
        file = here::here("data/coffee_data.RDS")
        )
