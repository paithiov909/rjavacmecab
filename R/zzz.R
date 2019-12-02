#' onLoad
#' @noRd
#' @param libname libname
#' @param pkgname pkgname
#' @importFrom rJava .jpackage
.onLoad <- function(libname, pkgname)
{
    rJava::.jpackage(pkgname, lib.loc = libname)
}

#' onUnload
#' @noRd
#' @param libpath libpath
.onUnload <- function(libpath)
{
    # library.dynam.unload("rjavacmecab", libpath)
}
