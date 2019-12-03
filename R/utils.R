#' Prettify cmecab_c() output
#'
#' @param list List that is output from cmecab_c()
#' @param sep String used as separator with which it replaces tab.
#' @return a tibble
#'
#' @importFrom purrr map_dfr
#' @importFrom stringr str_split_fixed
#' @importFrom dplyr bind_cols
#' @export
prettify <- function(list, sep = " ") {
    len <- length(list) - 1
    purrr::map_dfr(list[1:len], function(el) {
        split <- stringr::str_split_fixed(el, sep, 2L)
        word <- data.frame(word = split[1, 1], stringsAsFactors = FALSE)
        info <- stringr::str_split_fixed(split[1, 2], ",", Inf)
        colnames(info) <- c(
            "POS1",
            "POS2",
            "POS3",
            "POS4",
            "X5StageUse1",
            "X5StageUse2",
            "Original",
            "Yomi1",
            "Yomi2"
        )
        return(dplyr::bind_cols(
            as.data.frame(word, stringsAsFactors = FALSE),
            as.data.frame(info, stringsAsFactors = FALSE)
        ))
    })
}

#' Ngrams tokenizer
#'
#' Make n-gram tokenizer function.
#'
#' @seealso \url{https://rpubs.com/brianzive/textmining}
#'
#' @param n integer.
#' @param skip_word_none boolean.
#' @param locale single string, NULL or "" for default locale.
#'
#' @return n-gram tokenizer function.
#'
#' @import stringi
#' @export
ngram_tokenizer <- function(n = 1L,
             skip_word_none = TRUE,
             locale = NULL) {

        stopifnot(is.numeric(n), is.finite(n), n > 0)
        options <- stringi::stri_opts_brkiter(type = "word",
                                              locale = locale,
                                              skip_word_none = skip_word_none)

        function(x) {
            stopifnot(is.character(x))

            # Split into word tokens
            tokens <- unlist(stringi::stri_split_boundaries(x, opts_brkiter = options))
            len <- length(tokens)

            if (all(is.na(tokens)) || len < n) {
                # If we didn't detect any words or number of tokens is less than n return empty vector
                character(0)
            } else {
                sapply(1:max(1, len - n + 1), function(i) { stringi::stri_join(tokens[i:min(len, i + n - 1)], collapse = " ") })
            }
        }
    }

#' Return emoji subset
#'
#' @param version version digit.
#'
#' @return character representing regular expression that mactches emoji in Unicode code point order.
#'
#' @importFrom dplyr case_when
#' @export
emojiRegexp <- function(version = c(6.0, 7.0, 8.0)) {
    subset <- dplyr::case_when(
        version == 6.0 ~ "[\U0001F0CF-\U000207BF]",
        version == 7.0 ~ "[\U0001F321-\U000203FA]",
        version == 8.0 ~ "[\U0001F32D-\U0001F9C0]",
        TRUE ~ "[\U0001F32D-\U0001F9C0]"
    )
    return(subset)
}
