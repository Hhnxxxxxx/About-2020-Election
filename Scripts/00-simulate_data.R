library(dplyr)

set.seed(853)

num_obs <- 1000

# Simulate a dataset
us_political_preferences <- tibble(
  age_group = sample(c('18-24', '25-40', '41-56', '57-75', '76+'), size = num_obs, replace = TRUE),
  gender = sample(c('Male', 'Female'), size = num_obs, replace = TRUE),
  # Assuming an arbitrary mapping of age groups to a numeric scale
  support_prob = as.numeric(factor(age_group, levels = c('18-24', '25-40', '41-56', '57-75', '76+'))) / 4
) %>%
  mutate(
    # If random number is less than support_prob, they support Biden; otherwise, Trump
    support = if_else(runif(n = num_obs) < support_prob, 'Biden', 'Trump'),
    gender = if_else(gender == 'Male', 'Male', 'Female')
  ) %>%
  select(support, gender, age_group)

# Print the first few rows of the simulated dataset
print(head(us_political_preferences))
