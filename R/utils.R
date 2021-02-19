#' Call mecab command directly
#'
#' Calls mecab command directly via \code{base::system()}.
#'
#' @details It is useful especially when just tokenizing loads of text.
#' Since `mecab -Owakati` command is specially-tuned,
#' it is generally faster that you directly call mecab command
#' than programmatically use mecab tagger
#' if you would like to just tokenize (wakachi-gaki) texts.
#'
#' @param chr Character vector.
#' @param outfile Path to a file that MeCab writes output.
#' @param encoding Encoding of tempfile that MeCab reads.
#' @param opt Options passed to mecab command.
#' @param ... Any other arguments are passed to \code{base::writeLines()}.
#'
#' @return The function returns the value passed to `outfile` argument invisibly.
#'
#' @export
fastestword <- function(chr,
                        outfile = file.path(getwd(), "output.txt"),
                        encoding = "UTF-8",
                        opt = "-Owakati",
                        ...) {
  stopifnot(
    is.character(chr)
  )

  desc <- tempfile(fileext = ".txt")
  tempfile <- file(desc, open = "w+", encoding = encoding)
  writeLines(chr, con = tempfile, ...)
  close(tempfile)

  try(system(command = paste("mecab", desc, "-o", outfile, opt)))

  unlink(desc)
  return(invisible(outfile))
}


#' Normalize CJK text
#'
#' Normalize text into neologd-style.
#'
#' @seealso \url{https://github.com/neologd/mecab-ipadic-neologd/wiki/Regexp}
#'
#' @param str Character vector.
#'
#' @return Normalized text.
#'
#' @import stringr
#' @import stringi
#' @export
normalize <- function(str) {
  res <- str %>%
    stringi::stri_trans_nfkc() %>%
    stringr::str_replace_all("\u2019", "\'") %>%
    stringr::str_replace_all("\u201d", "\"") %>%
    stringr::str_replace_all("[\\-\u02d7\u058a\u2010\u2011\u2012\u2013\u2043\u207b\u208b\u2212]+", "-") %>%
    stringr::str_replace_all("[\ufe63\uff0d\uff70\u2014\u2015\u2500\u2501\u30fc]+", enc2utf8("\u30fc")) %>%
    stringr::str_replace_all("([:blank:]){2,}", " ") %>%
    stringr::str_replace_all(
      paste0(
        "([\uff10-\uff19\u3041-\u3093\u30a1-\u30f6\u30fc\u4e00-\u9fa0[:punct:]]*)",
        "[[:blank:]]+",
        "([[\uff10-\uff19\u3041-\u3093\u30a1-\u30f6\u30fc\u4e00-\u9fa0][:punct:]]+)"
      ),
      "\\1\\2") %>%
    stringr::str_remove_all("[~\u223c\u223e\u301c\u3030\uff5e]+") %>%
    stringr::str_remove_all("[[:cntrl:]]+")
  return(res)
}


#' Ngrams tokenizer
#'
#' Makes N-gram tokenizer function.
#'
#' @seealso \url{https://rpubs.com/brianzive/textmining}
#'
#' @param n Integer.
#' @param skip_word_none Boolean.
#' @param locale Character scalar, NULL or "" for default locale.
#'
#' @return N-gram tokenizer function.
#'
#' @import stringi
#' @export
ngram_tokenizer <- function(n = 1L, skip_word_none = TRUE, locale = NULL) {
  stopifnot(is.numeric(n), is.finite(n), n > 0)

  options <- stringi::stri_opts_brkiter(
    type = "word",
    locale = locale,
    skip_word_none = skip_word_none
  )

  func <- function(x) {
    stopifnot(is.character(x))

    # Split into word tokens
    tokens <- unlist(stringi::stri_split_boundaries(x, opts_brkiter = options))
    len <- length(tokens)

    if (all(is.na(tokens)) || len < n) {
      # If we didn't detect any words or number of tokens
      # is less than n return empty vector
      character(0)
    } else {
      sapply(1:max(1, len - n + 1), function(i) {
        stringi::stri_join(tokens[i:min(len, i + n - 1)], collapse = " ")
      })
    }
  }
  return(func)
}
