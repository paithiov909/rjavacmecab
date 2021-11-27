#' Prettify tokenized output
#'
#' @param list List that comes out of \code{rjavacmecab::cmecab()}
#' or \code{rjavacmecab::igo(mode = "parse")}.
#' @param sep Character scalar that is used as separators
#' with which the function replaces tab.
#' @param into Character vector that is used as column names of
#' features.
#'
#' @return data.frame.
#'
#' @export
prettify <- function(list,
                     sep = " ",
                     into = c(
                       "POS1",
                       "POS2",
                       "POS3",
                       "POS4",
                       "X5StageUse1",
                       "X5StageUse2",
                       "Original",
                       "Yomi1",
                       "Yomi2"
                     )) {
  stopifnot(
    rlang::is_list(list),
    rlang::is_character(sep)
  )
  res <- list %>%
    purrr::discard(~ purrr::is_empty(.)) %>%
    purrr::imap_dfr(function(elem, idx) {
      split <- stringi::stri_split_regex(elem, sep, 2L)
      data.frame(
        doc_id = idx,
        token = purrr::map_chr(split, ~ purrr::pluck(., 1)),
        Features = purrr::map_chr(split, ~ purrr::pluck(., 2))
      )
    }) %>%
    tidyr::separate(
      col = "Features",
      into = into,
      sep = ",",
      fill = "right"
    ) %>%
    dplyr::mutate_if(is.character, ~ dplyr::na_if(., "*"))
  return(res)
}
