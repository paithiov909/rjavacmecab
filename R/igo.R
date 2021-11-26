#' Rebuild Igo tagger
#'
#' Rebuild an instance of igo tagger using provided options.
#' The igo tagger instance is stored in the package internal environment.
#'
#' @param data_dir Character vector.
#' @return The stored tagger instance is returned invisibly.
#'
#' @keywords internal
rebuild_igo_tagger <- function(data_dir = .pkgenv[["igodic"]]) {
  igo_tagger(rJava::.jnew(
    "net.reduls.igo.Tagger",
    data_dir
  ))
  return(invisible(igo_tagger()))
}

#' Call Igo tagger
#'
#' @details
#' This function is a wrapper of Igo (v0.4.5) that is a Java reimplementaion of MeCab.
#' The Igo tagger has 2 methods, which are 'parse' and 'wakati', and both is available from this function.
#'
#' @param chr Character vector to be tokenized.
#' @param sep Character scalar to be used as separator
#' with which the function replaces tab.
#' @param split Logical. If true (by default), the function splits character vector
#' into sentences using \code{stringi::stri_split_boudaries(type = "sentence")}
#' before analyzing them.
#' @param mode Character scalar.
#' @return List.
#'
#' @export
igo <- function(chr, sep = " ", split = TRUE, mode = c("parse", "wakati")) {
  stopifnot(
    rlang::is_character(chr),
    rlang::is_character(sep),
    rlang::is_character(mode)
  )
  if (is.null(igo_tagger())) {
    rebuild_igo_tagger()
  }
  mode <- rlang::arg_match(mode, c("parse", "wakati"))

  # modify character vector
  if (split) {
    chr <- chr %>%
      stringi::stri_omit_na() %>%
      stringi::stri_split_boundaries(type = "sentence") %>%
      purrr::flatten_chr()
  }
  # keep names
  nm <- names(chr)
  if (identical(nm, NULL)) {
    nm <- seq_along(chr)
  }

  if (identical(mode, "wakati")) {
    res <- lapply(chr, function(str) {
      li <- igo_tagger()$wakati(str)
      map_chr(seq_len(li$size()), function(itr) {
        return(stringi::stri_join(
          li$get(as.integer(itr - 1)),
          sep = sep
        ))
      })
    })
  } else {
    res <- lapply(chr, function(str) {
      morphs <- igo_tagger()$parse(str)
      map_chr(seq_len(morphs$size()), function(itr) {
        return(stringi::stri_join(
          morphs$get(as.integer(itr - 1))$surface,
          morphs$get(as.integer(itr - 1))$feature,
          sep = sep
        ))
      })
    })
  }

  return(purrr::set_names(res, nm))
}
