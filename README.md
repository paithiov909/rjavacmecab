
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rjavacmecab <a href='https://paithiov909.github.io/rjavacmecab'><img src='man/figures/logo.png' align="right" height="139" /></a>

<!-- badges: start -->

[![GitHub last
commit](https://img.shields.io/github/last-commit/paithiov909/rjavacmecab)](#)
[![Lifecycle:
superseded](https://img.shields.io/badge/lifecycle-superseded-blue.svg)](https://lifecycle.r-lib.org/articles/stages.html#superseded)
[![R-CMD-check](https://github.com/paithiov909/rjavacmecab/actions/workflows/check.yml/badge.svg)](https://github.com/paithiov909/rjavacmecab/actions/workflows/check.yml)
[![Codecov test
coverage](https://codecov.io/gh/paithiov909/rjavacmecab/branch/main/graph/badge.svg)](https://app.codecov.io/gh/paithiov909/rjavacmecab?branch=main)
<!-- badges: end -->

> rJava Interface to CMeCab

rjavacmecab is an rJava interface to
[takscape/cmecab-java](https://github.com/takscape/cmecab-java) that is
a Java binding for MeCab.

The goal of this package is to provide the simplest way to help use
‘MeCab’ from R than alternatives
([RMeCab](https://github.com/IshidaMotohiro/RMeCab) and
[RcppMeCab](https://github.com/junhewk/RcppMeCab)).

rjavacmecab is yet slower, but it should be easier to use because…

1.  There is no need to build from C/C++ source.
2.  It returns all features of each nodes accessible via cmecab-java.

## System Requirements

rjavacmecab requires ‘MeCab’ (mecab, libmecab-dev and mecab-ipadic-utf8)
and JDK. Please note that they are installed and available before you
use rjavacmecab.

In case using base R and JDK for 32/64bit under Windows, you need
32/64bit build of libmecab.

## Usage

### Installation

``` r
remotes::install_github("paithiov909/rjavacmecab")
```

### Call Tagger

To make cmecab tagger available, `rebuild_tagger` at first.

``` r
rjavacmecab::rebuild_tagger()

res <- rjavacmecab::cmecab(c("長期的自己実現で福楽は得られない", "幸せは刹那の中にあり"))
str(res)
#> tibble [18 × 3] (S3: tbl_df/tbl/data.frame)
#>  $ doc_id : int [1:18] 1 1 1 1 1 1 1 1 1 1 ...
#>  $ token  : chr [1:18] "長期" "的" "自己" "実現" ...
#>  $ feature: chr [1:18] "名詞,一般,*,*,*,*,長期,チョウキ,チョーキ" "名詞,接尾,形容動詞語幹,*,*,*,的,テキ,テキ" "名詞,一般,*,*,*,*,自己,ジコ,ジコ" "名詞,サ変接続,*,*,*,*,実現,ジツゲン,ジツゲン" ...
```

### Prettify Output

``` r
res <- rjavacmecab::prettify(res)
str(res)
#> tibble [18 × 11] (S3: tbl_df/tbl/data.frame)
#>  $ doc_id     : int [1:18] 1 1 1 1 1 1 1 1 1 1 ...
#>  $ token      : chr [1:18] "長期" "的" "自己" "実現" ...
#>  $ POS1       : chr [1:18] "名詞" "名詞" "名詞" "名詞" ...
#>  $ POS2       : chr [1:18] "一般" "接尾" "一般" "サ変接続" ...
#>  $ POS3       : chr [1:18] NA "形容動詞語幹" NA NA ...
#>  $ POS4       : chr [1:18] NA NA NA NA ...
#>  $ X5StageUse1: chr [1:18] NA NA NA NA ...
#>  $ X5StageUse2: chr [1:18] NA NA NA NA ...
#>  $ Original   : chr [1:18] "長期" "的" "自己" "実現" ...
#>  $ Yomi1      : chr [1:18] "チョウキ" "テキ" "ジコ" "ジツゲン" ...
#>  $ Yomi2      : chr [1:18] "チョーキ" "テキ" "ジコ" "ジツゲン" ...
```

If you use IPA-styled dictionary, the output has these columns.

- doc_id: 文番号
- token: 表層形（surface form）
- POS1\~POS4: 品詞, 品詞細分類1, 品詞細分類2, 品詞細分類3
- X5StageUse1: 活用型（ex. 五段, 下二段…）
- X5StageUse2: 活用形（ex. 連用形, 基本形…）
- Original: 原形（lemmatised form）
- Yomi1: 読み（readings）
- Yomi2: 発音（pronunciation）

### Pack Output

``` r
res <- rjavacmecab::pack(res)
print(res)
#>   doc_id                                       text
#> 1      1 長期 的 自己 実現 で 福 楽 は 得 られ ない
#> 2      2                 幸せ は 刹那 の 中 に あり
```

### Use Igo

[Igo](http://igo.osdn.jp/) is a pure Java port of MeCab. rjavacmecab
also provides a wrapper function of that.

``` r
res <- rjavacmecab::igo("お前がそう思うんならそうなんだろう、お前ん中ではな")
str(res)
#> tibble [18 × 3] (S3: tbl_df/tbl/data.frame)
#>  $ doc_id : int [1:18] 1 1 1 1 1 1 1 1 1 1 ...
#>  $ token  : chr [1:18] "お前" "が" "そう" "思う" ...
#>  $ feature: chr [1:18] "名詞,代名詞,一般,*,*,*,お前,オマエ,オマエ" "助詞,格助詞,一般,*,*,*,が,ガ,ガ" "副詞,助詞類接続,*,*,*,*,そう,ソウ,ソー" "動詞,自立,*,*,五段・ワ行促音便,基本形,思う,オモウ,オモウ" ...
```

## License

BSD 3-clause License.

This software includes works that are distributed in Public Domain and
New BSD License. See
<https://github.com/takscape/cmecab-java/blob/master/README.txt> for
more details.

Icons made by [Vectors
Market](https://www.flaticon.com/authors/vectors-market) from
[Flaticon](https://www.flaticon.com/).
