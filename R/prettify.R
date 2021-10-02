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
  res <- imap_dfr(list, function(li, i) {
    li <- na_if(li, "EOS")
    map_dfr(stringi::stri_omit_na(li), function(elem) {
      split <- stringi::stri_split_regex(elem, sep, 2L)
      return(data.frame(
        sentence_id = i,
        token = map_chr(split, ~ purrr::pluck(., 1)),
        Features = map_chr(split, ~ purrr::pluck(., 2))
      ))
    })
  }) %>%
    tidyr::separate(
      col = "Features",
      into = into,
      sep = ",",
      fill = "right"
    ) %>%
    mutate_if(is.character, ~ na_if(., "*"))
  return(res)
}
