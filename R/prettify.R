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
    is.list(list),
    is.character(sep)
  )
  res <- purrr::imap_dfr(list, function(li, i) {
    len <- length(li) - 1L
    purrr::map_dfr(li[1:len], function(elem) {
      split <- stringi::stri_split_regex(elem, sep, 2L)
      return(data.frame(
        sentence_id = i,
        token = purrr::map_chr(split, ~ purrr::pluck(., 1)),
        Features = purrr::map_chr(split, ~ purrr::pluck(., 2))
      ))
    })
  })
  res <-
    tidyr::separate(
      res,
      col = "Features",
      into = into,
      sep = ",",
      fill = "right"
    ) %>%
      dplyr::mutate_if(is.character, ~ dplyr::na_if(., "*"))
  return(res)
}
