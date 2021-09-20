#' Pack prettified output
#'
#' @param df Output of \code{rjavacmecab::prettify}.
#' @param pull Column name to be packed into data.frame. Default value is `token`.
#' @param .collapse This argument is passed to \code{stringi::stri_c()}.
#' @return data.frame.
#'
#' @export
pack <- function(df, pull = "token", .collapse = " ") {
  res <- df %>%
    dplyr::group_by(sentence_id) %>%
    dplyr::group_map(
      ~ dplyr::pull(.x, {{ pull }}) %>%
        stringi::stri_c(collapse = .collapse)
    ) %>%
    purrr::imap_dfr(~ data.frame(doc_id = .y, text = .x))
  return(res)
}
