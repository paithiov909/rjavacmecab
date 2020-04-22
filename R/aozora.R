#' Dowload text file from Aozora Bunko
#'
#' Download a file from specified Aozora Bunko URL and unzip the file,
#' convert it to UTF-8 format.
#'
#' @param url URL of text download link.
#' @param txtname New file name as which text will be saved.
#' @param directory Direcotry name where new file will be saved.
#'
#' @seealso \url{https://gist.github.com/ishida-m/7969049}
#'
#' @return the path to the new file
#'
#' @import stringr
#' @importFrom readr write_lines
#' @importFrom utils download.file
#' @importFrom utils unzip
#' @importFrom dplyr %>%
#' @export
aozora <- function(url = NULL,
                   txtname = NULL,
                   directory = "cache") {
  tmp <- tempfile()
  utils::download.file(url, tmp)
  textF <- utils::unzip(tmp, exdir = tempdir())
  unlink(tmp)

  if (length(textF) > 1) {
    location <- stringr::str_which(textF, ".txt$")
    textF <- textF[location]
  }
  if (is.null(txtname)) {
    txtname <- stringr::str_split(basename(textF), ".txt$", simplify = TRUE)[1]
  }
  connection <- file(textF, open = "rt")
  newDir <- file.path(getwd(), directory)
  newFile <- paste0(file.path(newDir, "/"), paste0(txtname, ".txt"))
  if (file.create(newFile)) {
    outfile <- file(newFile, open = "at", encoding = "UTF-8")
  }

  flag <- TRUE
  reg1 <- enc2native("\U005E\U5E95\U672C") %>% iconv(to = "CP932")
  reg2 <- enc2native("\U3010\U5165\U529B\U8005\U6CE8\U3011") %>% iconv(to = "CP932")
  reg3 <- enc2native("\UFF3B\UFF03\U005B\U005E\UFF3D\U005D\U002A\UFF3D") %>% iconv(to = "CP932")
  reg4 <- enc2native("\U300A\U005B\U005E\U300B\U005D\U002A\U300B") %>% iconv(to = "CP932")
  reg5 <- enc2native("\UFF5C") %>% iconv(to = "CP932")

  lines <- readLines(connection, n = -1L, encoding = "CP932")
  for (line in lines) {
    if (stringr::str_detect(line, reg1)) break
    if (stringr::str_detect(line, reg2)) break
    if (stringr::str_detect(line, "^(--)+")) {
      flag <- !flag
      next
    }
    if (flag) {
      line <- line %>%
        stringr::str_replace("^[-]+", "") %>%
        stringr::str_replace_all(reg3, "") %>%
        stringr::str_replace_all(reg4, "") %>%
        stringr::str_replace_all(reg5, "")
      readr::write_lines(line, outfile, append = TRUE)
    }
  }
  close(connection)
  close(outfile)

  return(newFile)
}
