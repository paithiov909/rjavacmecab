Sys.setenv(MECAB_LANG = "ja")
if(!requireNamespace("RMeCab")) install.packages("RMeCab", repos = "http://rmecab.jp/R")
if(!requireNamespace("RcppMeCab")) remotes::install_github("paithiov909/RcppMeCab")
