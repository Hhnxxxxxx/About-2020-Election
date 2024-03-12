library(testthat)

# Test 1: Dataset has 1000 observations
test_that("Dataset has correct number of observations", {
  expect_equal(nrow(us_political_preferences), 1000)
})

# Test 2: Dataset has correct columns
test_that("Dataset has correct columns", {
  expect_true(all(c("support", "gender", "age_group") %in% names(us_political_preferences)))
})

# Test 3: `support` column has correct values
test_that("`support` column contains 'Biden' or 'Trump'", {
  expect_true(all(us_political_preferences$support %in% c("Biden", "Trump")))
})

# Test 4: `gender` column has correct values
test_that("`gender` column contains 'Male' or 'Female'", {
  expect_true(all(us_political_preferences$gender %in% c("Male", "Female")))
})

# Test 5: `age_group` column has correct values
test_that("`age_group` column contains correct age groups", {
  expect_true(all(us_political_preferences$age_group %in% c('18-24', '25-40', '41-56', '57-75', '76+')))
})

# Test 6: `support_prob` probabilities make sense
test_that("`support_prob` probabilities are non-negative", {
  expect_true(all(us_political_preferences$support_prob >= 0))
})

# Run all tests
test_dir("tests")