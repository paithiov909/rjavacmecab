#' Environment for internal use
#'
#' @noRd
#' @keywords internal
.pkgenv <- rlang::env(igodic = NULL, stdtagger = NULL, igotagger = NULL)

#' Standard Tagger
#'
#' For internal use. This function stores an rJava binding as standard tagger instance.
#'
#' @noRd
#' @param obj An rJava binding object to be stored.
#' @return Reference to <net.moraleboost.mecab.impl.StandardTagger> class instance.
#' @keywords internal
standard_tagger <- function(obj = NULL) {
  if (!is.null(obj)) rlang::env_bind(.pkgenv, stdtagger = obj)
  return(.pkgenv[["stdtagger"]])
}

#' Igo Tagger
#'
#' For internal use. This function stores an rJava binding as igo tagger instance.
#'
#' @noRd
#' @param obj An rJava binding object to be stored.
#' @return Reference to <net.reduls.igo.Tagger> class instance.
#' @keywords internal
igo_tagger <- function(obj = NULL) {
  if (!is.null(obj)) rlang::env_bind(.pkgenv, igotagger = obj)
  return(.pkgenv[["igotagger"]])
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
      "inst/java/cmecab-java-2.1.0.jar",
      "inst/java/igo-0.4.5.jar"
    ),
    lib.loc = libname
  )
  # Initialize
  rlang::env_bind(
    .pkgenv,
    igodic = system.file("igo-ipadic", package = pkgname, lib.loc = libname)
  )
  if (is_mecab_available()) {
    rebuild_tagger()
  }
}
