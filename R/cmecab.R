#' Rebuild CMeCab tagger
#'
#' Rebuild instance of tagger using provided options.
#'
#' @param opt character vector.
#'
#' @return return the stored tagger instance invisibly.
#'
#' @export
rebuild_tagger <- function(opt = "") {
  standard_tagger(rJava::.jnew(
    "net.moraleboost.mecab.impl.StandardTagger",
    paste(opt, collapse = " ")
  ))
  return(invisible(standard_tagger()))
}

#' Call CMeCab tagger
#'
#' @param chr Character vector to be tokenized.
#' @param opt Character scalar to be passed as tagger options (ex. "-d").
#' @param sep Character scalar to be used as separator
#' with which the function replaces tab.
#'
#' @return List.
#'
#' @export
cmecab <- function(chr, opt = "", sep = " ") {
  stopifnot(
    is.character(chr),
    is.character(opt),
    is.character(sep),
    is_mecab_available()
  )
  if (!is_blank(opt)) {
    rebuild_tagger(opt = opt)
  }
  lattice <- standard_tagger()$createLattice()

  lattice$setSentence(paste(stringi::stri_enc_toutf8(chr), collapse = "\n"))
  standard_tagger()$parse(lattice)

  parsed <- lattice$toString()

  lattice$destroy()

  Encoding(parsed) <- "UTF-8"
  parsed <- stringr::str_replace_all(parsed, stringr::fixed("\t"), sep)
  parsed <- stringr::str_split(parsed, pattern = "\n")
  res <- purrr::flatten(parsed)
  len <- length(res) - 1L

  return(res[1:len])
}
