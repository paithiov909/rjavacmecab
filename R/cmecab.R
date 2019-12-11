#' Call CMeCab tagger
#'
#' @param str String to be tokenized
#' @param opt String to be passed as tagger options (ex. "-d").
#' @param sep String used as separator with which it replaces tab.
#' @return a list
#'
#' @import rJava
#' @importFrom stringr str_replace_all
#' @importFrom stringr str_split
#' @importFrom stringr fixed
#' @importFrom purrr flatten
#' @export
cmecab_c <- function(str = "", opt = "", sep = " ")
{

    rJava::.jaddClassPath("inst/java/bridj-0.7.0.jar")
    rJava::.jaddClassPath("inst/java/cmecab-java-2.1.0.jar")

    rJava::javaImport(packages = "net.moraleboost.mecab.Lattice")
    rJava::javaImport(packages = "net.moraleboost.mecab.Tagger")
    rJava::javaImport(packages = "net.moraleboost.mecab.impl.StandardTagger")

    # rJava::javaImport(packages = "mecab.MECAB_TOKEN_BOUNDARY")
    # rJava::javaImport(packages = "mecab.MECAB_ANY_BOUNDARY")
    # rJava::javaImport(packages = "mecab.MECAB_INSIDE_TOKEN")

    tagger <- rJava::.jnew("net.moraleboost.mecab.impl.StandardTagger", opt)
    lattice <- tagger$createLattice()

    lattice$setSentence(paste0(iconv(str, to = "UTF-8"), "\n"))
    tagger$parse(lattice)

    parsed <- lattice$toString()

    lattice$destroy()
    tagger$destroy()

    Encoding(parsed) <- "UTF-8"
    parsed <- stringr::str_replace_all(parsed, stringr::fixed("\t"), sep)
    parsed <- stringr::str_split(parsed, pattern = "\n")
    res <- purrr::flatten(parsed)
    len <- length(res) - 1

    return(res[1:len])
}



