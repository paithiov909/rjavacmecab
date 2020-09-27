#' onLoad
#' @noRd
#' @param libname libname
#' @param pkgname pkgname
#' @import rJava
#' @keywords internal
.onLoad <- function(libname, pkgname) {
  rJava::.jpackage(pkgname,
    morePaths = c("inst/java/bridj-0.7.0.jar", "inst/java/cmecab-java-2.1.0.jar"),
    lib.loc = libname
  )

  rJava::javaImport(packages = "net.moraleboost.mecab.impl.StandardTagger")
  rJava::javaImport(packages = "net.moraleboost.util.CSVUtil")
}
