#' Pack prettified output
#'
#' @param df Output of \code{rjavacmecab::prettify}
#' @param pull Column name to be packed into data.frame. Default value is `token`.
#' @param .collapse This argument will be passed to \code{paste()}.
#' @return data.frame.
#'
#' @import dplyr
#' @import stringr
#' @importFrom furrr future_map_dfr
#' @importFrom tibble rowid_to_column
#' @export
pack <- function(df, pull = "token", .collapse = " ") {
  res <- df %>%
    dplyr::group_map(
      ~ dplyr::pull(.x, {{ pull }}) %>%
        stringr::str_c(collapse = .collapse)
    ) %>%
    furrr::future_map_dfr(~ data.frame(text = .)) %>%
    tibble::rowid_to_column("doc_id")
  return(res)
}
