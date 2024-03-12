library(tidyverse)
library(dataverse)
library(knitr)

ces2020 <-
  get_dataframe_by_name(
    filename = "CES20_Common_OUTPUT_vv.csv",
    dataset = "10.7910/DVN/E9N6PH",
    server = "dataverse.harvard.edu",
    .f = read_csv
  ) |>
  select(votereg, CC20_410, gender, birthyr)

write_csv(ces2020, "ces2020.csv")

ces2020 <-
  read_csv(
    "ces2020.csv",
    col_types =
      cols(
        "votereg" = col_integer(),
        "CC20_410" = col_integer(),
        "gender" = col_integer(),
        "birthyr" = col_integer()
      )
  )

ces2020

head(ces2020, 6) |>
  kable(
    col.names = c("Vote Registration", "Vote Choice", "Gender", "Birth Year"),
    booktabs = TRUE
  )