sentence <- enc2utf8(
  paste0(
    "\u3075\u3068\u632F\u308A\u5411\u304F\u3068\u3001\u305F\u304F",
    "\u3055\u3093\u306E\u5473\u65B9\u304C\u3044\u3066\u305F\u304F",
    "\u3055\u3093\u306E\u512A\u3057\u3044\u4EBA\u9593\u304C\u3044",
    "\u308B\u3053\u3068\u3092\u3001\u308F\u3056\u308F\u3056\u81EA",
    "\u5206\u306E\u8A95\u751F\u65E5\u304C\u6765\u306A\u3044\u3068",
    "\u6C17\u4ED8\u3051\u306A\u3044\u81EA\u5206\u3092\u596E\u3044",
    "\u7ACB\u305F\u305B\u306A\u304C\u3089\u3082\u3001\u6BCE\u65E5",
    "\u3053\u3093\u306A\u3001\u6E56\u306E\u3088\u3046\u306A\u306A",
    "\u3093\u306E\u5F15\u3063\u639B\u304B\u308A\u3082\u306A\u3044",
    "\u3001\u843D\u3061\u3064\u304D\u5012\u3057\u3001\u97F3\u4E00",
    "\u3064\u3082\u611F\u3058\u3055\u305B\u306A\u3044\u4EBA\u9593",
    "\u3067\u3044\u308C\u308B\u65B9\u306B\u61A7\u308C\u3092\u6301",
    "\u3066\u305F\u3068\u3042\u308B25\u6B73\u306E\u7729\u3057\u304D",
    "\u671D\u306E\u3053\u3068\u3067\u3057\u305F"
  )
)

test_that("igo stops", {
  expect_error(igo(NA))
  expect_error(igo(NULL))
  expect_error(igo("", mode = NULL))
})
test_that("igo output are a data.frame", {
  expect_s3_class(igo(NA_character_), "data.frame")
  expect_s3_class(igo(sentence), "data.frame")
})
test_that("igo output are valid", {
  expect_equal(
    as.data.frame(igo(sentence))[2, 2],
    enc2utf8("\u632f\u308a\u5411\u304f")
  )
  expect_equal(igo(sentence, mode = "wakati")[[1]][2], enc2utf8("\u632f\u308a\u5411\u304f"))
})
