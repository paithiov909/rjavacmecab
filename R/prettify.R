#' Prettify tokenized output
#'
#' @param list List that comes out of \code{rjavacmecab::cmecab()}
#' or \code{rjavacmecab::igo(mode = "parse")}.
#' @param sep Character scalar that is used as separators
#' with which the function replaces tab.
#' @param into Character vector that is used as column names of
#' features.
#'
#' @return data.frame.
#'
#' @export
prettify <- function(list,
                     sep = " ",
                     into = get_dict_features("ipa")) {
  stopifnot(
    rlang::is_list(list),
    rlang::is_character(sep)
  )
  list %>%
    purrr::discard(~ purrr::is_empty(.)) %>%
    purrr::imap_dfr(function(elem, idx) {
      split <- stringi::stri_split_regex(elem, sep, 2L)
      data.frame(
        doc_id = idx,
        token = purrr::map_chr(split, ~ purrr::pluck(., 1)),
        Features = purrr::map_chr(split, ~ purrr::pluck(., 2))
      )
    }) %>%
    tidyr::separate(
      col = "Features",
      into = into,
      sep = ",(?=(?:[^\\\"]*\"[^\\\"]*\\\")*(?![^\\\"]*\\\"))",
      fill = "right"
    ) %>%
    dplyr::mutate_if(is.character, ~ dplyr::na_if(., "*"))
}

#' Get features of dictionary
#'
#' Returns features of dictionary.
#' Currently supports "unidic17" (2.1.2 src schema), "unidic26" (2.1.2 bin schema),
#' "unidic29" (schema used in 2.2.0, 2.3.0), "cc-cedict", "ko-dic" (mecab-ko-dic),
#' and "ipa".
#'
#' @seealso See also
#' \href{https://ccd.ninjal.ac.jp/unidic/}{UniDic},
#' \href{https://github.com/ueda-keisuke/CC-CEDICT-MeCab}{CC-CEDICT-MeCab},
#' and \href{https://bitbucket.org/eunjeon/mecab-ko-dic/src/master/}{mecab-ko-dic}.
#' @param dict Character scalar; one of "ipa", "unidic17", "unidic26", "unidic29",
#' "cc-cedict", or "ko-dic".
#' @return A character vector.
#' @export
get_dict_features <- function(dict = c(
                                "ipa",
                                "unidic17",
                                "unidic26",
                                "unidic29",
                                "cc-cedict",
                                "ko-dic"
                              )) {
  dict <- rlang::arg_match(dict)
  feat <- dplyr::case_when(
    dict == "unidic17" ~ list(c(
      "POS1", "POS2", "POS3", "POS4", "cType", "cForm", "lForm",
      "lemma", "orth", "pron",
      "orthBase", "pronBase", "goshu", "iType", "iForm", "fType", "fForm"
    )),
    dict == "unidic26" ~ list(c(
      "POS1", "POS2", "POS3", "POS4", "cType", "cForm", "lForm", "lemma", "orth", "pron",
      "orthBase", "pronBase", "goshu", "iType", "iForm", "fType", "fForm",
      "kana", "kanaBase", "form", "formBase", "iConType", "fConType", "aType",
      "aConType", "aModeType"
    )),
    dict == "unidic29" ~ list(c(
      "POS1", "POS2", "POS3", "POS4", "cType",
      "cForm", "lForm", "lemma", "orth", "pron", "orthBase", "pronBase", "goshu", "iType", "iForm", "fType",
      "fForm", "iConType", "fConType", "type", "kana", "kanaBase", "form", "formBase", "aType", "aConType",
      "aModType", "lid", "lemma_id"
    )),
    dict == "cc-cedict" ~ list(c(
      "POS1", "POS2", "POS3", "POS4",
      "pinyin_pron", "traditional_char_form", "simplified_char_form",
      "definition"
    )),
    dict == "ko-dic" ~ list(c(
      "POS", "meaning", "presence", "reading", "type", "first_pos", "last_pos", "expression"
    )),
    TRUE ~ list(c("POS1", "POS2", "POS3", "POS4", "X5StageUse1", "X5StageUse2", "Original", "Yomi1", "Yomi2"))
  )
  unlist(feat)
}
