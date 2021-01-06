#' Standard Tagger
#'
#' Store the rJava binding to the tagger.
#'
#' @noRd
#' @param obj An rJava binding object to be stored.
#' @return Reference to <net.moraleboost.mecab.impl.StandardTagger> class instance.
#' @keywords internal
standard_tagger <- (function() {
  if (!exists("instance")) instance <- NULL
  function(obj = NULL) {
    if (!is.null(obj)) instance <<- obj
    return(instance)
  }
})()

#' onLoad
#'
#' @noRd
#' @param libname libname
#' @param pkgname pkgname
#' @import rJava
#' @import purrr
#' @import stringi
#' @import stringr
#' @import tidyr
#' @keywords internal
.onLoad <- function(libname, pkgname) {
  rJava::.jpackage(pkgname,
    morePaths = c(
      "inst/java/bridj-0.7.0.jar",
      "inst/java/cmecab-java-2.1.0.jar"
    ),
    lib.loc = libname
  )
  ## Initialize
  rebuild_tagger(opt = "")
}
