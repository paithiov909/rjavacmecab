#' Check if scalars are blank
#'
#' @details This function is a port of \code{rapportools::is.empty()}.
#' Thus the source of this function is licensed under AGPL-3.
#' @seealso \url{https://github.com/Rapporter/rapportools/blob/master/R/utils.R#L334}
#'
#' @param x Object to check its emptiness.
#' @param trim Boolean.
#' @param ... Additional arguments for \code{base::sapply()}.
#' @return Logical values.
#'
#' @importFrom stringr str_trim
#' @export
is_blank <- function(x, trim = TRUE, ...) {
  if (!is.list(x) && length(x) <= 1) {
    if (is.null(x)) {
      return(TRUE)
    }
    if (length(x) == 0) {
      return(TRUE)
    }
    if (is.na(x) || is.nan(x)) {
      return(TRUE)
    }
    if (is.character(x) && nchar(ifelse(trim, stringr::str_trim(x), x)) == 0) {
      return(TRUE)
    }
    return(FALSE)
  } else {
    sapply(x, is_blank, trim = trim, ...)
  }
}
