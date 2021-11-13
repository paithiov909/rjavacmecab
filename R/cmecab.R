#' Rebuild CMeCab tagger
#'
#' Rebuild an instance of standard tagger using provided options.
#' The standard tagger instance is stored in the package internal environment.
#'
#' @param opt Character vector.
#' @return The stored tagger instance is returned invisibly.
#'
#' @export
rebuild_tagger <- function(opt = "") {
  standard_tagger(.jnew(
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
#' @param split Logical. If true (by default), the function splits character vector
#' into sentences using \code{tokenizers::tokenize_sentences} before analyzing them.
#' @return List.
#'
#' @export
cmecab <- function(chr, opt = "", sep = " ", split = TRUE) {
  stopifnot(
    rlang::is_character(chr),
    rlang::is_character(opt),
    rlang::is_character(sep)
  )
  if (!is_blank(opt)) {
    rebuild_tagger(opt = opt)
  }
  if (is.null(standard_tagger())) rlang::abort("There is no tagger instance available. Please `rebuild_tagger` at first.")

  # create lattice
  lattice <- standard_tagger()$createLattice()
  on.exit(lattice$destroy())

  # modify chracter vector
  chr <- stringi::stri_omit_na(chr)
  if (split) {
    chr <- purrr::flatten_chr(stringi::stri_split_boundaries(chr, type = "sentence"))
  }

  # analyze character vector
  parsed <- map_chr(chr, function(str) {
    lattice$setSentence(str)
    standard_tagger()$parse(lattice)
    return(lattice$toString())
  })

  # make result
  Encoding(parsed) <- "UTF-8"
  res <- parsed %>%
    stringi::stri_replace_all_fixed(pattern = "\t", replace = sep) %>%
    stringi::stri_split_fixed(pattern = "\n") %>%
    map(function(li) {
      len <- length(li) - 1L
      return(li[1:len])
    })

  return(res)
}
