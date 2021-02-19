#### fastestword ####
describe("Check fastestword", {
  it("Stop properly?", {
    expect_error(
      fastestword(
        NULL,
        outfile = file.path(tempfile(fileext = ".txt"))
      )
    )
  })
  it("Valid output?", {
    res <- fastestword(
      sentence,
      outfile = file.path(tempfile(fileext = ".txt"))
    )
    expect_type(readLines(res), "character")
  })
})


#### normalize ####
test_that("Check normalize", { ## TODO: check more letters
  expect_equal(
    normalize(enc2utf8("\u3001.")),
    ""
  )
})


#### ngram_tokenizer ####
test_that("Check ngram_tokenizer", {
  expect_type(ngram_tokenizer(3L), "closure")
  expect_type(
    ngram_tokenizer(2L)(NA_character_),
    "character"
  )
  expect_equal(
    ngram_tokenizer(2L)(c("a", "b", "c", "d")),
    c("a b", "b c", "c d")
  )
})
