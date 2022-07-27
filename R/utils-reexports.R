#' Pipe operator
#'
#' @name %>%
#' @rdname pipe
#' @keywords internal
#' @importFrom dplyr %>%
#' @export
#' @usage lhs \%>\% rhs
NULL

#' Prettify tokenized output
#'
#' @param df A data.frame that comes out of
#' \code{rjavacmecab::cmecab(mode = "parse")}
#' or \code{rjavacmecab::igo(mode = "parse")}.
#' @param into Character vector that is used as column names of
#' features.
#' @param col_select Character or integer vector that will be kept
#' in prettified features.
#' @return A data.frame.
#' @importFrom audubon prettify
#' @export
prettify <- function(df,
                     into = get_dict_features("ipa"),
                     col_select = seq_along(into)) {
  audubon::prettify(df, into = into, col_select = col_select)
}

#' Get dictionary's features
#'
#' @inherit audubon::get_dict_features description return details seealso
#' @inheritParams audubon::get_dict_features
#' @importFrom audubon get_dict_features
#' @export
get_dict_features <- audubon::get_dict_features

#' Pack prettified data.frame of tokens
#'
#' @inherit audubon::pack description return details sections seealso
#' @inheritParams audubon::pack
#' @importFrom audubon pack
#' @export
pack <- audubon::pack
