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
    stringi::stri_join(opt, collapse = " ")
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
#' into sentences using \code{stringi::stri_split_boundaries(type = "sentence")} before analyzing them.
#' @param mode Character scalar.
#' @return List.
#'
#' @export
cmecab <- function(chr, opt = "", sep = " ", split = TRUE,  mode = c("parse", "wakati")) {
  stopifnot(
    rlang::is_character(chr),
    rlang::is_character(opt),
    rlang::is_character(sep),
    rlang::is_character(mode)
  )
  mode <- rlang::arg_match(mode, c("parse", "wakati"))

  if (!is_blank(opt)) {
    rebuild_tagger(opt = opt)
  }
  if (is.null(standard_tagger())) rlang::abort("There is no tagger instance available. Please `rebuild_tagger` at first.")

  # create lattice
  lattice <- standard_tagger()$createLattice()
  on.exit(lattice$destroy())

  # keep names
  nm <- names(chr)
  if (identical(nm, NULL)) {
    nm <- seq_along(chr)
  }

  res <- chr %>%
    tidyr::replace_na("") %>%
    purrr::map(function(elem) {
      if (split) {
        elem <- elem %>%
          stringi::stri_split_boundaries(type = "sentence") %>%
          purrr::flatten_chr()
      }
      lines <- purrr::map_chr(elem, function(str) {
        lattice$setSentence(str)
        standard_tagger()$parse(lattice)
        lattice$toString()
      })
      Encoding(lines) <- "UTF-8"

      if (identical(mode, "wakati")) {
       parsed <- lines %>%
          stringi::stri_replace_all_fixed(pattern = "\t", replace = sep) %>%
          stringi::stri_split_fixed(pattern = "\n") %>%
          purrr::map(function(li) {
            li %>%
              stringi::stri_split_fixed(pattern = sep) %>%
              purrr::map_chr(~ purrr::pluck(., 1L)) %>%
              dplyr::na_if("EOS") %>%
              stringi::stri_omit_empty_na()
          })
      } else {
        parsed <- lines %>%
          stringi::stri_replace_all_fixed(pattern = "\t", replace = sep) %>%
          stringi::stri_split_fixed(pattern = "\n") %>%
          purrr::map(function(li) {
            li %>%
              dplyr::na_if("EOS") %>%
              stringi::stri_omit_empty_na()
          })
      }
      purrr::flatten_chr(parsed)
    })

  return(purrr::set_names(res, nm))
}
