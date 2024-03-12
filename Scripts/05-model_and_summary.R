library(rstanarm)
library(modelsummary)

set.seed(853)

# Randomly sample 1000 observations from the cleaned dataset
ces2020_reduced <- 
  ces2020_cleaned |> 
  slice_sample(n = 1000)

# Convert 'voted_for' from character to binary numeric
ces2020_reduced$voted_for <- ifelse(ces2020_reduced$voted_for == "Biden", 1, 0)

# Ensure 'gender' and 'age_group' are factors
ces2020_reduced$gender <- factor(ces2020_reduced$gender)
ces2020_reduced$age_group <- factor(ces2020_reduced$age_group)

# Build the logistic regression model
political_preferences_age_gender <- stan_glm(
  voted_for ~ gender + age_group,
  data = ces2020_reduced,
  family = binomial(link = "logit"),
  prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
  prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
  seed = 853
)

# Save the model to an RDS file
saveRDS(political_preferences_age_gender, file = "political_preferences_age_gender.rds")

# Load the model for summary or further analysis
political_preferences_age_gender <- readRDS(file = "political_preferences_age_gender.rds")

# Use the modelsummary function to create the summary table
modelsummary(
  list(
    "Support Biden" = political_preferences_age_gender
  ),
  statistic = "mad"
)

modelplot(political_preferences_age_gender, conf_level = 0.9) +
  labs(x = "90 per cent credibility interval")