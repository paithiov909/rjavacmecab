#' Call CMeCab tagger
#'
#' @param chr Character vector to be tokenized.
#' @param opt Character scalar to be passed as tagger options (ex. "-d").
#' @param sep Character scalar to be used as separator
#' with which the function replaces tab.
#' @return List.
#'
#' @importFrom rJava .jnew
#' @importFrom stringi stri_enc_toutf8
#' @importFrom stringr str_replace_all
#' @importFrom stringr str_split
#' @importFrom stringr fixed
#' @importFrom purrr flatten
#' @export
cmecab <- function(chr, opt = "", sep = " ") {
  stopifnot(is.character(chr))
  tagger <- rJava::.jnew("net.moraleboost.mecab.impl.StandardTagger", opt)
  lattice <- tagger$createLattice()

  lattice$setSentence(paste0(stringi::stri_enc_toutf8(chr), "\n"))
  tagger$parse(lattice)

  parsed <- lattice$toString()

  lattice$destroy()
  tagger$destroy()

  Encoding(parsed) <- "UTF-8"
  parsed <- stringr::str_replace_all(parsed, stringr::fixed("\t"), sep)
  parsed <- stringr::str_split(parsed, pattern = "\n")
  res <- purrr::flatten(parsed)
  len <- length(res) - 1

  return(res[1:len])
}
