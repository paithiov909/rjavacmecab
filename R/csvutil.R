#' Utility for handling CSV-like string
#'
#' Parses a CSV-row-like string something like `"a,b,c"`.
#'
#' @param str Character scalar.
#' @param max Limitation of column size.
#' @return Character vector
#'
#' @importFrom rJava J
#' @export
tokenize <- function(str, max = 99L) {
  if (!is.character(str) || length(str) != 1L || is.na(str)) {
    message("Invalid string provided. String must be a character scalar, not NA_character_.")
    stop()
  } else {
    arr <- rJava::J("net.moraleboost.util.CSVUtil")$tokenize(str, as.integer(max))
    return(arr)
  }
}

#' Utility for handling CSV-like string
#'
#' Escapes space, tab, `"` and `,` in string.
#'
#' @param str Character scalar.
#' @return Character scalar.
#'
#' @importFrom rJava J
#' @export
escape <- function(str) {
  if (!is.character(str) || length(str) != 1L || is.na(str)) {
    message("Invalid string provided. String must be a character scalar, not NA_character_.")
    stop()
  } else {
    str <- rJava::J("net.moraleboost.util.CSVUtil")$escape(str)
    return(str)
  }
}

#' Utility for handling CSV-like string
#'
#' Equivalent to \code{paste(chr, collapse = ",")}.
#'
#' @param char Character vector.
#' @return Character scalar.
#'
#' @importFrom rJava J
#' @importFrom rJava .jarray
#' @export
join <- function(chr) {
  stopifnot(is.character(chr), !is.na(chr))
  arr <- rJava::J("net.moraleboost.util.CSVUtil")$join(rJava::.jarray(chr))
  return(arr)
}
