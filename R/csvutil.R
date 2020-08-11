#' Util for Handling CSV-like string
#'
#' Parse a CSV-row-like string something like `"a,b,c"`
#'
#' @param str String.
#' @param max Integer. The limitation of column size.
#' @return vector
#'
#' @importFrom rJava J
#' @export
tokenize <- function(str, max = 99L) {
  arr <- rJava::J("net.moraleboost.util.CSVUtil")$tokenize(str, max)
  return(arr)
}


#' Util for Handling CSV-like string
#'
#' Escape space, tab, `"` and `,` in string
#'
#' @param str String.
#' @return String
#'
#' @importFrom rJava J
#' @export
escape <- function(str) {
  str <- rJava::J("net.moraleboost.util.CSVUtil")$escape(str)
  return(str)
}


#' Util for Handling CSV-like string
#'
#' Equivalent to `paste(char, collapse = ",")`
#'
#' @param char Character vector.
#' @return String
#'
#' @importFrom rJava J
#' @importFrom rJava .jarray
#' @export
join <- function(char) {
  elem <- c(char)
  arr <- rJava::J("net.moraleboost.util.CSVUtil")$join(rJava::.jarray(elem))
  return(arr)
}
