#### tokenize ####
describe("Check tokenize", {
  it("Stop properly?", {
    expect_error(tokenize(list()))
    expect_error(tokenize(c("a", "b")))
  })
  it("Valid output?", {
    expect_equal(tokenize("a,b,c"), c("a", "b", "c"))
  })
})


#### escape ####
describe("Check escape", {
  it("Stop properly?", {
    expect_error(escape(list()))
    expect_error(escape(c("a", "b")))
  })
})


#### join ####
describe("Check join", {
  it("Stop properly?", {
    expect_error(join(list()))
  })
  it("Valid output?", {
    expect_type(join(c("a", "b")), "character")
    expect_length(join(c("a", "b")), 1L)
  })
})
