#### is_blank ####
test_that("is_blank works", {
  expect_true(is_blank(list()))
  expect_true(is_blank(NULL))
  expect_equal(is_blank(c("", NA_character_), USE.NAMES = FALSE), c(TRUE, TRUE))
})
