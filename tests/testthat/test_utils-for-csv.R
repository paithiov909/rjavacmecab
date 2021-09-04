#### tokenize ####
test_that("tokenize stops properly", {
  expect_error(tokenize(list()))
  expect_error(tokenize(c("a", "b")))
})
test_that("tokenize output is valid", {
  expect_equal(tokenize("a,b,c"), c("a", "b", "c"))
})

#### escape ####
test_that("escape stops properly", {
  expect_error(escape(list()))
  expect_error(escape(c("a", "b")))
})

#### join ####
test_that("join stops properly", {
  expect_error(join(list()))
})
test_that("join output is valid", {
  expect_type(join(c("a", "b")), "character")
  expect_length(join(c("a", "b")), 1L)
})
