#' Call CMeCab tagger
#'
#' @param str String to be tokenized
#' @param opt String to be passed as tagger options (ex. "-d").
#' @param sep String used as separator with which it replaces tab.
#' @return a list
#'
#' @importFrom rJava .jnew
#' @importFrom stringr str_conv
#' @importFrom stringr str_replace_all
#' @importFrom stringr str_split
#' @importFrom stringr fixed
#' @importFrom purrr flatten
#' @export
cmecab_c <- function(str = "", opt = "", sep = " ")
{
    tagger <- rJava::.jnew("net.moraleboost.mecab.impl.StandardTagger", opt)
    lattice <- tagger$createLattice()

    lattice$setSentence(paste0(stringr::str_conv(str, encoding = "UTF-8"), "\n"))
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



