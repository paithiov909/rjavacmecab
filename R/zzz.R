#' Environment for internal use
#'
#' @noRd
#' @keywords internal
.pkgenv <- rlang::env(instance = NULL)

#' Standard Tagger
#'
#' For internal use. This function stores an rJava binding as tagger instance.
#'
#' @noRd
#' @param obj An rJava binding object to be stored.
#' @return Reference to <net.moraleboost.mecab.impl.StandardTagger> class instance.
#' @keywords internal
standard_tagger <- function(obj = NULL) {
  if (!is.null(obj)) rlang::env_bind(.pkgenv, instance = obj)
  return(.pkgenv[["instance"]])
}

#' On load
#'
#' @noRd
#' @param libname libname
#' @param pkgname pkgname
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
  if (is_dyn_available()) {
    rebuild_tagger()
  }
}
