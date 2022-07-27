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
#' @param split Logical. If true (by default), the function splits character vector
#' into sentences using \code{stringi::stri_split_boudaries(type = "sentence")}
#' before analyzing them.
#' @param mode Character scalar.
#' @return A tibble.
#'
#' @export
igo <- function(chr, split = FALSE, mode = c("parse", "wakati")) {
  stopifnot(
    rlang::is_character(chr),
    rlang::is_logical(split),
    rlang::is_character(mode)
  )
  if (is.null(igo_tagger())) {
    rebuild_igo_tagger()
  }
  mode <- rlang::arg_match(mode, c("parse", "wakati"))

  # keep names
  nm <- names(chr)
  if (identical(nm, NULL)) {
    nm <- seq_along(chr)
  }

  if (identical(mode, "wakati")) {
    res <-
      data.frame(doc_id = nm, value = chr) %>%
      dplyr::filter(!is_blank(.data$value)) %>%
      dplyr::group_by(.data$doc_id) %>%
      dplyr::mutate(value = purrr::map(.data$value, function(str) {
        if (split) {
          str <- str %>%
            stringi::stri_split_boundaries(type = "sentence") %>%
            purrr::flatten_chr()
        }
        li <- igo_tagger()$wakati(str)
        purrr::map_chr(seq_len(li$size()), function(itr) {
          li$get(as.integer(itr - 1))
        })
      })) %>%
      dplyr::group_by(.data$doc_id) %>%
      dplyr::group_map(
        ~ purrr::set_names(.x$value, .y$doc_id)
      ) %>%
      purrr::flatten()
  } else {
    res <-
      data.frame(doc_id = nm, value = chr) %>%
      dplyr::filter(!is_blank(.data$value)) %>%
      dplyr::group_by(.data$doc_id) %>%
      dplyr::mutate(value = purrr::map(.data$value, function(str) {
        if (split) {
          str <- str %>%
            stringi::stri_split_boundaries(type = "sentence") %>%
            purrr::flatten_chr()
        }
        morphs <- igo_tagger()$parse(str)
        purrr::map_dfr(seq_len(morphs$size()), function(itr) {
          data.frame(
            token = morphs$get(as.integer(itr - 1))$surface,
            feature = morphs$get(as.integer(itr - 1))$feature
          )
        })
      })) %>%
      dplyr::ungroup() %>%
      tidyr::unnest(.data$value)
  }
  return(res)
}
