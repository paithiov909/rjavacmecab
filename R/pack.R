#' Pack prettified data.frame of tokens
#'
#' Pack prettified data.frame of tokens into a new data.frame of corpus
#' compatible with the Text Interchange Formats.
#'
#' @seealso \url{https://github.com/ropensci/tif}
#'
#' @param df Prettified data.frame of tokens.
#' @param n Integer internally passed to ngrams tokenizer function
#' created of \code{rjavacmecab::ngram_tokenizer()}
#' @param pull Column to be packed into text or ngrams body. Default value is `token`.
#' @param sep Character scalar internally used as the concatenator of ngrams.
#' @param .collapse Character scalar passed to \code{stringi::stri_c()}.
#' @return data.frame
#'
#' @export
pack <- function(df, n = 1L, pull = "token", sep = "-", .collapse = " ") {
  res <- df %>%
    group_by(.data$doc_id) %>%
    group_map(
      ~ ngram_tokenizer(n)(dplyr::pull(.x, {{ pull }}), sep = sep) %>%
        stringi::stri_c(collapse = .collapse)
    ) %>%
    imap_dfr(~ data.frame(doc_id = .y, text = .x))
  return(res)
}

#' Ngrams tokenizer
#'
#' Make an ngram tokenizer function.
#'
#' @param n Integer.
#' @param skip_word_none Logical.
#' @param locale Character scalar. Pass a `NULL` or an empty string for default locale.
#'
#' @return ngram tokenizer function
#'
#' @export
ngram_tokenizer <- function(n = 1L, skip_word_none = TRUE, locale = NULL) {
  stopifnot(is.numeric(n), is.finite(n), n > 0)

  options <- stringi::stri_opts_brkiter(
    type = "word",
    locale = locale,
    skip_word_none = skip_word_none
  )

  func <- function(x, sep = " ") {
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
        stringi::stri_join(tokens[i:min(len, i + n - 1)], collapse = sep)
      })
    }
  }
  return(func)
}
