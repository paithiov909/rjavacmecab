data("MiyazawaKenji")

describe("Check aozora", {
  it("Works properly?", {
    path <- aozora(
      MiyazawaKenji[1, ]$url,
      NULL,
      tempdir()
    )
    expect_type(readLines(path), "character")
  })
})
