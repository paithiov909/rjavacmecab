#' Prettify cmecab output
#'
#' @param list List that comes out of \code{rjavacmecab::cmecab()}.
#' @param sep Character scalar that is used as separators
#' with which the function replaces tab.
#' @param into Character vector that is used as column names of
#' features.
#'
#' @return data.frame.
#'
#' @import dplyr
#' @import stringr
#' @importFrom furrr future_map_dfr
#' @importFrom tidyr separate
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
  stopifnot(is.list(list), !is_blank(list), is.character(sep))
  len <- length(list) - 1L
  res <- furrr::future_map_dfr(list[1:len], function(elem) {
    split <- stringr::str_split_fixed(elem, sep, 2L)
    words <- data.frame(token = split[1, 1], stringsAsFactors = FALSE)
    info <- tidyr::separate(
      data.frame(Features = c(split[1, 2]), stringsAsFactors = FALSE),
      col = "Features",
      into = into,
      sep = ",",
      fill = "right"
    )
    return(dplyr::bind_cols(
      as.data.frame(words, stringsAsFactors = FALSE),
      dplyr::summarise_all(info, ~ dplyr::na_if(., "*"))
    ))
  })
  return(res)
}
