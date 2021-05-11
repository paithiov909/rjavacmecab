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
    stringr::str_c(opt, collapse = " ")
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
    rlang::is_character(sep),
    is_dyn_available()
  )
  if (!is_blank(opt)) {
    rebuild_tagger(opt = opt)
  }
  if (!rlang::env_has(.pkgenv, "instance")) rlang::abort("There is no tagger instance available. Please `rebuild_tagger` at first.")

  lattice <- standard_tagger()$createLattice()

  parsed <- purrr::map_chr(stringi::stri_enc_toutf8(chr), function(str) {
    str <- tidyr::replace_na(chr, "")
    lattice$setSentence(str)
    standard_tagger()$parse(lattice)
    return(lattice$toString())
  })

  lattice$destroy()

  Encoding(parsed) <- "UTF-8"
  parsed <- stringr::str_replace_all(parsed, stringr::fixed("\t"), sep)
  parsed <- stringr::str_split(parsed, pattern = "\n")
  res <- lapply(parsed, function(li) {
    len <- length(li) - 1L
    return(li[1:len])
  })

  return(res)
}
