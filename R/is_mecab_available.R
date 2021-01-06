#' Check if mecab command is available
#'
#' @return Logical.
#'
#' @export
is_mecab_available <- function() {
  return(!is_blank(Sys.which("mecab")))
}
