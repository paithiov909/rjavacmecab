#' Util for Handling CSV-like string
#'
#' parse a CSV-row-like string something like `"a,b,c"`
#'
#' @param str character scalar..
#' @param max integer. the limitation of column size.
#' @return character vector
#'
#' @importFrom rJava J
#' @export
tokenize <- function(str, max = 99L) {
  arr <- rJava::J("net.moraleboost.util.CSVUtil")$tokenize(str, max)
  return(arr)
}

#' Util for Handling CSV-like string
#'
#' escape space, tab, `"` and `,` in string
#'
#' @param str character scalar.
#' @return character scalar.
#'
#' @importFrom rJava J
#' @export
escape <- function(str) {
  str <- rJava::J("net.moraleboost.util.CSVUtil")$escape(str)
  return(str)
}

#' Util for Handling CSV-like string
#'
#' equivalent to \code{paste(char, collapse = ",")}
#'
#' @param char character vector.
#' @return character scalar
#'
#' @importFrom rJava J
#' @importFrom rJava .jarray
#' @export
join <- function(char) {
  elem <- c(char)
  arr <- rJava::J("net.moraleboost.util.CSVUtil")$join(rJava::.jarray(elem))
  return(arr)
}
