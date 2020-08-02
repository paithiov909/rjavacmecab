Sys.setenv(MECAB_LANG = "ja")
if(!require("RMeCab")){ install.packages("RMeCab", repos = "http://rmecab.jp/R") }
if(!require("RcppMeCab")){ remotes::install_github("paithiov909/RcppMeCab") }
