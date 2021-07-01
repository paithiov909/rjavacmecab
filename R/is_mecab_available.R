#' Check if the mecab or its dynamic library is available
#'
#' @return Logical.
#'
#' @export
is_mecab_available <- function() {
  if (.Platform$OS.type == "windows") {
    return(!is_blank(Sys.which(paste0("libmecab", .Platform$dynlib.ext))))
  } else {
    return(!is_blank(Sys.which(paste0("mecab"))))
  }
}
