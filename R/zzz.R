#' Initialization
#'
#' @param libname
#' @param pkgname
#' @importFrom rJava .jpackage
.onLoad <- function(libname, pkgname)
{
    rJava::.jpackage(pkgname, lib.loc = libname)
}
