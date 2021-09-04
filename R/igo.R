#' Rebuild Igo tagger
#'
#' Rebuild an instance of igo tagger using provided options.
#' The igo tagger instance is stored in the package internal environment.
#'
#' @param data_dir Character vector.
#' @return The stored tagger instance is returned invisibly.
#'
#' @keywords internal
rebuild_igo_tagger <- function(data_dir = .pkgenv[["igodic"]]) {
  igo_tagger(rJava::.jnew(
    "net.reduls.igo.Tagger",
    data_dir
  ))
  return(invisible(igo_tagger()))
}

#' Call Igo tagger
#'
#' @details
#' This function is a wapper of Igo (v0.4.5) that is a Java reimplementaion of MeCab.
#' The Igo tagger has 2 methods, which are 'parse' and 'wakati', and both is available from this function.
#'
#' @param chr Character vector to be tokenized.
#' @param sep Character scalar to be used as separator
#' with which the function replaces tab.
#' @param mode Charcter scalar.
#' @return List.
#'
#' @examples
#' igo(enc2utf8("\u3053\u306e\u6728\u306a\u3093\u306e\u6728"))
#' igo(enc2utf8("\u6c17\u306b\u306a\u308b\u6728"), mode = "wakati")
#' @export
igo <- function(chr, sep = " ", mode = c("parse", "wakati")) {
  stopifnot(
    rlang::is_character(chr),
    rlang::is_character(sep),
    rlang::is_character(mode)
  )
  if (is.null(igo_tagger())) {
    rebuild_igo_tagger()
  }
  mode <- rlang::arg_match(mode, c("parse", "wakati"))

  if (identical(mode, "wakati")) {
    res <- lapply(stringi::stri_enc_toutf8(chr), function(str) {
      li <- igo_tagger()$wakati(tidyr::replace_na(str, ""))
      purrr::map_chr(seq_len(li$size()), function(itr) {
        return(stringi::stri_c(
          li$get(as.integer(itr - 1)),
          sep = sep
        ))
      })
    })
  } else {
    res <- lapply(stringi::stri_enc_toutf8(chr), function(str) {
      morphs <- igo_tagger()$parse(tidyr::replace_na(str, ""))
      purrr::map_chr(seq_len(morphs$size()), function(itr) {
        return(stringi::stri_c(
          morphs$get(as.integer(itr - 1))$surface,
          morphs$get(as.integer(itr - 1))$feature,
          sep = sep
        ))
      })
    })
  }
  return(res)
}
