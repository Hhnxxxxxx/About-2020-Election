library(dplyr)

# Clean the dataset
ces2020_cleaned <- ces2020 %>%
  filter(votereg == 1, !is.na(CC20_410), CC20_410 %in% c(1, 2)) %>%
  mutate(
    voted_for = if_else(CC20_410 == 1, "Biden", "Trump"),
    age = 2020 - birthyr,
    age_group = case_when(
      age >= 18 & age <= 24 ~ "young_voters",
      age > 24 & age <= 40 ~ "millennials",
      age > 40 & age <= 56 ~ "generation_X",
      age > 56 & age <= 75 ~ "baby_boomers",
      age > 75 ~ "silent_generation"
    ),
    gender = if_else(gender == 1, "Male", "Female")
  ) %>%
  select(voted_for, gender, age_group)

# Write the cleaned dataset to a new CSV file
write.csv(ces2020_cleaned, "ces2020_cleaned.csv", row.names = FALSE)

ces2020_cleaned |>
  ggplot(aes(x = age_group, fill = voted_for)) +
  stat_count(position = "dodge") +
  facet_wrap(facets = vars(gender)) +
  theme_minimal() +
  labs(
    x = "Age group",
    y = "Number of respondents",
    fill = "Voted for"
  ) +
  coord_flip() +
  scale_fill_brewer(palette = "Set1") +
  theme(legend.position = "bottom", panel.spacing = unit(1, "lines"))