#' Rebuild CMeCab tagger
#'
#' Rebuild an instance of tagger using provided options.
#' The tagger instance is stored in the package internal environment.
#'
#' @param opt Character vector.
#' @return The stored tagger instance is returned invisibly.
#'
#' @export
rebuild_tagger <- function(opt = "") {
  standard_tagger(rJava::.jnew(
    "net.moraleboost.mecab.impl.StandardTagger",
    stringi::stri_c(opt, collapse = " ")
  ))
  return(invisible(standard_tagger()))
}

#' Call CMeCab tagger
#'
#' @param chr Character vector to be tokenized.
#' @param opt Character scalar to be passed as tagger options (ex. "-d").
#' @param sep Character scalar to be used as separator
#' with which the function replaces tab.
#' @return List.
#'
#' @export
cmecab <- function(chr, opt = "", sep = " ") {
  stopifnot(
    rlang::is_character(chr),
    rlang::is_character(opt),
    rlang::is_character(sep)
  )
  if (!is_blank(opt)) {
    rebuild_tagger(opt = opt)
  }
  if (is.null(.pkgenv[["instance"]])) rlang::abort("There is no tagger instance available. Please `rebuild_tagger` at first.")

  lattice <- standard_tagger()$createLattice()

  parsed <- purrr::map_chr(stringi::stri_enc_toutf8(chr), function(str) {
    str <- tidyr::replace_na(str, "")
    lattice$setSentence(str)
    standard_tagger()$parse(lattice)
    return(lattice$toString())
  })

  lattice$destroy()

  Encoding(parsed) <- "UTF-8"
  parsed <- stringi::stri_replace_all_fixed(parsed, "\t", sep)
  parsed <- stringi::stri_split_fixed(parsed, pattern = "\n")
  res <- lapply(parsed, function(li) {
    len <- length(li) - 1L
    return(li[1:len])
  })

  return(res)
}
