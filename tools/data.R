library(tidyverse)

#### Slothlib ####
StopWordsJp <- readr::read_csv("http://svn.sourceforge.jp/svnroot/slothlib/CSharp/Version1/SlothLib/NLP/Filter/StopWord/word/Japanese.txt", col_names = FALSE)
StopWordsJp <- StopWordsJp %>%
    rename(word = X1) %>%
    rowid_to_column()
usethis::use_data(StopWordsJp, overwrite = TRUE)

#### Special_chars ####
ExtendedLettersJp <- scan("tools/cp932_special_chars.txt", what = "char")
ExtendedLettersJp <- stringr::str_split(ExtendedLettersJp, "", simplify = TRUE)
ExtendedLettersJp <- t(ExtendedLettersJp) %>%
    as.data.frame(stringsAsFactors = FALSE) %>%
    as_tibble() %>%
    rename(char = V1) %>%
    rowid_to_column()
usethis::use_data(ExtendedLettersJp, overwrite = TRUE)

#### One_letters ####
OneLettersJp <- readr::read_csv("tools/one_letters.csv")
usethis::use_data(OneLettersJp, overwrite = TRUE)

