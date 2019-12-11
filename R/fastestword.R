#' Call mecab command directly
#'
#' Call mecab command directly via system().
#' It is useful especially when just tokenizing loads of text.
#'
#' Since `mecab -Owakati` command is specially-tuned,
#' it is generally faster that you directly call mecab command
#' than programmatically use mecab tagger
#' if you would like to just tokenize (wakachi-gaki) of Japanese text.
#'
#' @param chr character vector.
#' @param outfile fullpath to a file that MeCab will write output.
#' @param encoding encoding of tempfile that MeCab will read.
#' @param ... arguments passed to writeLines()
#'
#' @return return the value pased to `outfile` argument invisibly
#'
#' @export
fastestword <- function(chr = c(""),
                        outfile = file.path(getwd(), "output.txt"),
                        encoding = "UTF-8",
                        opt = "-Owakati",
                        ...) {

    desc <- tempfile(fileext = ".txt")
    tempfile <- file(desc, open = "w+", encoding = encoding)
    writeLines(chr, con = tempfile, ...)
    close(tempfile)

    try(system(command = paste("mecab", desc, "-o", outfile, opt)))

    unlink(desc)
    invisible(outfile)

}
