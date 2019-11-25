#' Initialization
#'
#' @importFrom rJava .jpackage
.onLoad <- function(libname, pkgname)
{
    rJava::.jpackage(pkgname, lib.loc = libname)
}
