#' Utility for handling CSV-like string
#'
#' Parse a CSV-row-like string something like `"a,b,c"`.
#'
#' @param str Character scalar.
#' @param max Integer (column size limit).
#' @return Character vector.
#'
#' @export
csvutil_tokenize <- function(str, max = 99L) {
  if (!is.character(str) || length(str) != 1L || is.na(str)) {
    rlang::abort("Invalid string provided. String must be a character scalar, not NA_character_.")
  } else {
    arr <- J("net.moraleboost.util.CSVUtil")$tokenize(str, as.integer(max))
    return(arr)
  }
}

#' Utility for handling CSV-like string
#'
#' Escape space, tab, `"` and `,` in string.
#'
#' @param str Character scalar.
#' @return Character scalar.
#'
#' @export
csvutil_escape <- function(str) {
  if (!is.character(str) || length(str) != 1L || is.na(str)) {
    rlang::abort("Invalid string provided. String must be a character scalar, not NA_character_.")
  } else {
    str <- J("net.moraleboost.util.CSVUtil")$escape(str)
    return(str)
  }
}

#' Utility for handling CSV-like string
#'
#' Equivalent to \code{paste(chr, collapse = ",")}.
#'
#' @param chr Character vector.
#' @return Character scalar.
#'
#' @export
csvutil_join <- function(chr) {
  stopifnot(is.character(chr), !is.na(chr))
  arr <- J("net.moraleboost.util.CSVUtil")$join(.jarray(chr))
  return(arr)
}
