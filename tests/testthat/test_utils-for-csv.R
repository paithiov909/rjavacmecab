#### tokenize ####
test_that("tokenize stops properly", {
  expect_error(csvutil_tokenize(list()))
  expect_error(csvutil_tokenize(c("a", "b")))
})
test_that("tokenize output is valid", {
  expect_equal(csvutil_tokenize("a,b,c"), c("a", "b", "c"))
})

#### escape ####
test_that("escape stops properly", {
  expect_error(csvutil_escape(list()))
  expect_error(csvutil_escape(NA_character_))
})
test_that("escape output is valid", {
  expect_type(csvutil_escape("a,b,c"), "character")
})

#### join ####
test_that("join stops properly", {
  expect_error(csvutil_join(list()))
})
test_that("join output is valid", {
  expect_type(csvutil_join(c("a", "b")), "character")
  expect_length(csvutil_join(c("a", "b")), 1L)
})
