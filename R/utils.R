#' Check if mecab command is available
#' @return Logical.
#' @export
is_mecab_available <- function() {
  return(!is_blank(Sys.which("mecab")))
}


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
    is.character(chr),
    is_mecab_available()
  )

  desc <- tempfile(fileext = ".txt")
  tempfile <- file(desc, open = "w+", encoding = encoding)
  writeLines(chr, con = tempfile, ...)
  close(tempfile)

  try(system(command = paste("mecab", desc, "-o", outfile, opt)))

  unlink(desc)
  return(invisible(outfile))
}


#' Prettify cmecab output
#'
#' @param list List that comes out of \code{rjavacmecab::cmecab()}.
#' @param sep Character scalar that is used as separators
#' with which the function replaces tab.
#' @return data.frame.
#'
#' @importFrom purrr map_dfr
#' @importFrom stringr str_split_fixed
#' @importFrom tidyr separate
#' @importFrom tidyr replace_na
#' @importFrom dplyr summarise_all
#' @importFrom dplyr bind_cols
#' @export
prettify <- function(list, sep = " ") {
  stopifnot(is.list(list), !is_blank(list), is.character(sep))
  len <- length(list) - 1
  res <- purrr::map_dfr(list[1:len], function(elem) {
    split <- stringr::str_split_fixed(elem, sep, 2L)
    words <- data.frame(Surface = split[1, 1], stringsAsFactors = FALSE)
    info <- tidyr::separate(
      data.frame(Features = c(split[1, 2]), stringsAsFactors = FALSE),
      col = "Features",
      into = c(
        "POS1",
        "POS2",
        "POS3",
        "POS4",
        "X5StageUse1",
        "X5StageUse2",
        "Original",
        "Yomi1",
        "Yomi2"
      ),
      sep = ",",
      fill = "right"
    )
    return(dplyr::bind_cols(
      as.data.frame(words, stringsAsFactors = FALSE),
      dplyr::summarise_all(info, ~ tidyr::replace_na(., "*"))
    ))
  })
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
