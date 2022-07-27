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
#' @param split Logical. If true (by default), the function splits character vector
#' into sentences using \code{stringi::stri_split_boundaries(type = "sentence")} before analyzing them.
#' @param mode Character scalar.
#' @return A tibble.
#'
#' @export
cmecab <- function(chr, opt = "", split = FALSE, mode = c("parse", "wakati")) {
  stopifnot(
    rlang::is_character(chr),
    rlang::is_character(opt),
    rlang::is_logical(split),
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
      lines <- purrr::map_chr(str, function(elem) {
        lattice$setSentence(elem)
        standard_tagger()$parse(lattice)
        lattice$toString()
      })
      Encoding(lines) <- "UTF-8"
      lines %>%
        stringi::stri_split_lines(omit_empty = TRUE) %>%
        purrr::flatten_chr() %>%
        stringi::stri_replace_all_fixed("EOS", "") %>%
        stringi::stri_omit_empty_na() %>%
        stringi::stri_split_regex("\\t") %>%
        purrr::map_dfr(
          ~ data.frame(
            token = .[1],
            feature = .[2]
          )
        )
    })) %>%
    dplyr::ungroup() %>%
    tidyr::unnest(.data$value)

  if (identical(mode, "wakati")) {
    res <- res %>%
      dplyr::group_by(.data$doc_id) %>%
      dplyr::group_map(
        ~ purrr::set_names(list(.x$token), .y$doc_id)
      ) %>%
      purrr::flatten()
  }
  return(res)
}
