#' onLoad
#' @param libname libname
#' @param pkgname pkgname
#' @importFrom rJava .jpackage
.onLoad <- function(libname, pkgname)
{
    rJava::.jpackage(pkgname, lib.loc = libname)
}

#' onUnload
.onUnload <- function(libpath)
{
    library.dynam.unload("rjavacmecab", libpath)
}
