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
    group_by(!!sym("sentence_id")) %>%
    group_map(
      ~ pull(.x, {{ pull }}) %>%
        stringi::stri_c(collapse = .collapse)
    ) %>%
    imap_dfr(~ data.frame(doc_id = .y, text = .x))
  return(res)
}
