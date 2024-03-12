library(testthat)

# Test 1: The dataset has the correct number of columns
test_that("Dataset has the correct number of columns", {
  expect_equal(ncol(ces2020_cleaned), 3)
})

# Test 2: The dataset contains the specified columns
test_that("Dataset has the correct columns", {
  expect_true(all(c("voted_for", "gender", "age_group") %in% names(ces2020_cleaned)))
})

# Test 3: 'voted_for' column should only contain 'Biden' or 'Trump'
test_that("'voted_for' column is correct", {
  expect_true(all(ces2020_cleaned$voted_for %in% c("Biden", "Trump")))
})

# Test 4: 'gender' column should only contain 'Male' or 'Female'
test_that("'gender' column is correct", {
  expect_true(all(ces2020_cleaned$gender %in% c("Male", "Female")))
})

# Test 5: 'age_group' column contains correct age groups
test_that("'age_group' column contains correct categories", {
  expected_age_groups <- c("Young Voters", "Millennials", "Generation X", "Baby Boomers", "Silent Generation")
  expect_true(all(ces2020_cleaned$age_group %in% expected_age_groups))
})

# Test 6: There are no missing values in key columns
test_that("There are no missing values in key columns", {
  expect_true(all(complete.cases(ces2020_cleaned[c("voted_for", "gender", "age_group")])))
})

# Run the tests
test_dir("path_to_test_directory")
