#### is_blank ####
test_that("is_blank works", {
  expect_true(is_blank(list()))
  expect_true(is_blank(NULL))
  expect_equal(is_blank(c("", NA_character_), USE.NAMES = FALSE), c(TRUE, TRUE))
})

#### get_dict_features ####
test_that("get_dict_features works", {
  expect_equal(length(get_dict_features()), 9L)
  expect_equal(length(get_dict_features("unidic17")), 17L)
  expect_equal(length(get_dict_features("unidic26")), 26L)
  expect_equal(length(get_dict_features("unidic29")), 29L)
  expect_equal(length(get_dict_features("cc-cedict")), 8L)
  expect_equal(length(get_dict_features("ko-dic")), 8L)
})
