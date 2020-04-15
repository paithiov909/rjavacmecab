#' onLoad
#' @noRd
#' @param libname libname
#' @param pkgname pkgname
#' @import rJava
.onLoad <- function(libname, pkgname) {
  rJava::.jpackage(pkgname, lib.loc = libname)

  rJava::.jaddClassPath("inst/java/bridj-0.7.0.jar")
  rJava::.jaddClassPath("inst/java/cmecab-java-2.1.0.jar")

  rJava::javaImport(packages = "net.moraleboost.mecab.Lattice")
  rJava::javaImport(packages = "net.moraleboost.mecab.Tagger")
  rJava::javaImport(packages = "net.moraleboost.mecab.impl.StandardTagger")

  # rJava::javaImport(packages = "mecab.MECAB_TOKEN_BOUNDARY")
  # rJava::javaImport(packages = "mecab.MECAB_ANY_BOUNDARY")
  # rJava::javaImport(packages = "mecab.MECAB_INSIDE_TOKEN")
}

#' onUnload
#' @noRd
#' @param libpath libpath
.onUnload <- function(libpath) {
  #
}
