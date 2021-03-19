#' Check if the mecab dynamic library is available
#'
#' @param dynlib Default value is 'libmecab'.
#' @return Logical.
#'
#' @export
is_dyn_available <- function(dynlib = "libmecab") {
  return(!is_blank(Sys.which(paste0(dynlib, .Platform$dynlib.ext))))
}
