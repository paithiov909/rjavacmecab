## code to prepare `slothlib` dataset goes here
StopWordsJp <- readr::read_csv("http://svn.sourceforge.jp/svnroot/slothlib/CSharp/Version1/SlothLib/NLP/Filter/StopWord/word/Japanese.txt", col_names = FALSE)
StopWordsJp <- StopWordsJp %>%
  rename(word = X1) %>%
  rowid_to_column()

usethis::use_data(StopWordsJp, overwrite = TRUE)
