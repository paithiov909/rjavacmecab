
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rjavacmecab <a href='https://paithiov909.github.io/rjavacmecab'><img src='https://rawcdn.githack.com/paithiov909/rjavacmecab/3075fa2aee8ec83c8f35a482cab1cf137de50d24/man/figures/logo.png' align="right" height="139" /></a>

<!-- badges: start -->

[![GitHub last
commit](https://img.shields.io/github/last-commit/paithiov909/rjavacmecab)](#)
[![Lifecycle:
stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable)
[![R-CMD-check](https://github.com/paithiov909/rjavacmecab/actions/workflows/R-CMD-check.yml/badge.svg)](https://github.com/paithiov909/rjavacmecab/actions/workflows/R-CMD-check.yml)
[![Codecov test
coverage](https://codecov.io/gh/paithiov909/rjavacmecab/branch/main/graph/badge.svg)](https://codecov.io/gh/paithiov909/rjavacmecab?branch=main)
<!-- badges: end -->

> rJava Interface to CMeCab

## System Requirements

-   MeCab
-   Java

## Installation

``` r
remotes::install_github("paithiov909/rjavacmecab")
```

## Usage

### Call Tagger

``` r
res <- rjavacmecab::cmecab(c("長期的自己実現で福楽は得られない", "幸せは刹那の中にあり"))
str(res)
#> List of 2
#>  $ : chr [1:12] "長期 名詞,一般,*,*,*,*,長期,チョウキ,チョーキ" "的 名詞,接尾,形容動詞語幹,*,*,*,的,テキ,テキ" "自己 名詞,一般,*,*,*,*,自己,ジコ,ジコ" "実現 名詞,サ変接続,*,*,*,*,実現,ジツゲン,ジツゲン" ...
#>  $ : chr [1:8] "幸せ 名詞,形容動詞語幹,*,*,*,*,幸せ,シアワセ,シアワセ" "は 助詞,係助詞,*,*,*,*,は,ハ,ワ" "刹那 名詞,副詞可能,*,*,*,*,刹那,セツナ,セツナ" "の 助詞,連体化,*,*,*,*,の,ノ,ノ" ...
```

### Prettify Output

``` r
res <- rjavacmecab::prettify(res)
str(res)
#> 'data.frame':    18 obs. of  11 variables:
#>  $ sentence_id: int  1 1 1 1 1 1 1 1 1 1 ...
#>  $ token      : chr  "長期" "的" "自己" "実現" ...
#>  $ POS1       : chr  "名詞" "名詞" "名詞" "名詞" ...
#>  $ POS2       : chr  "一般" "接尾" "一般" "サ変接続" ...
#>  $ POS3       : chr  NA "形容動詞語幹" NA NA ...
#>  $ POS4       : chr  NA NA NA NA ...
#>  $ X5StageUse1: chr  NA NA NA NA ...
#>  $ X5StageUse2: chr  NA NA NA NA ...
#>  $ Original   : chr  "長期" "的" "自己" "実現" ...
#>  $ Yomi1      : chr  "チョウキ" "テキ" "ジコ" "ジツゲン" ...
#>  $ Yomi2      : chr  "チョーキ" "テキ" "ジコ" "ジツゲン" ...
```

If you use IPA-styled dictionary, the output has these columns.

-   sentence\_id: 文番号
-   token: 表層形（surface form）
-   POS1\~POS4: 品詞, 品詞細分類1, 品詞細分類2, 品詞細分類3
-   X5StageUse1: 活用型（ex. 五段, 下二段…）
-   X5StageUse2: 活用形（ex. 連用形, 基本形…）
-   Original: 原形（lemmatised form）
-   Yomi1: 読み（readings）
-   Yomi2: 発音（pronunciation）

### Pack Output

``` r
res <- rjavacmecab::pack(res)
print(res)
#>   doc_id                                       text
#> 1      1 長期 的 自己 実現 で 福 楽 は 得 られ ない
#> 2      2                 幸せ は 刹那 の 中 に あり
```

### Change Dictionary

``` r
str <- c("Fate/Grand Order", "田村ゆかりのいたずら黒うさぎ")
rjavacmecab::cmecab(str, sep = "\t")
#> [[1]]
#> [1] "Fate\t名詞,固有名詞,組織,*,*,*,*"  "/\t名詞,サ変接続,*,*,*,*,*"       
#> [3] "Grand\t名詞,一般,*,*,*,*,*"        "Order\t名詞,固有名詞,組織,*,*,*,*"
#> [5] "EOS"                              
#> 
#> [[2]]
#> [1] "田村\t名詞,固有名詞,人名,姓,*,*,田村,タムラ,タムラ"        
#> [2] "ゆかり\t名詞,固有名詞,人名,名,*,*,ゆかり,ユカリ,ユカリ"    
#> [3] "の\t助詞,連体化,*,*,*,*,の,ノ,ノ"                          
#> [4] "いたずら\t名詞,サ変接続,*,*,*,*,いたずら,イタズラ,イタズラ"
#> [5] "黒\t名詞,一般,*,*,*,*,黒,クロ,クロ"                        
#> [6] "うさぎ\t名詞,一般,*,*,*,*,うさぎ,ウサギ,ウサギ"            
#> [7] "EOS"
rjavacmecab::cmecab(str, "-d /MeCab/ipadic-neologd", sep = "\t")
#> [[1]]
#> [1] "Fate/Grand Order\t名詞,固有名詞,一般,*,*,*,Fate/Grand Order,フェイトグランドオーダー,フェイトグランドオーダー"
#> [2] "EOS"                                                                                                          
#> 
#> [[2]]
#> [1] "田村ゆかりのいたずら黒うさぎ\t名詞,固有名詞,一般,*,*,*,田村ゆかりのいたずら黒うさぎ,タムラユカリノイタズラクロウサギ,タムラユカリノイタズラクロウサギ"
#> [2] "EOS"
```

### Use Igo

[Igo](http://igo.osdn.jp/) is a pure Java port of MeCab. rjavacmecab
also provides a wrapper function of that.

``` r
res <- rjavacmecab::igo("お前がそう思うんならそうなんだろう、お前ん中ではな")
str(res)
#> List of 1
#>  $ : chr [1:18] "お前 名詞,代名詞,一般,*,*,*,お前,オマエ,オマエ" "が 助詞,格助詞,一般,*,*,*,が,ガ,ガ" "そう 副詞,助詞類接続,*,*,*,*,そう,ソウ,ソー" "思う 動詞,自立,*,*,五段・ワ行促音便,基本形,思う,オモウ,オモウ" ...
```

## Alternatives

-   [IshidaMotohiro/RMeCab: Interface to
    MeCab](https://github.com/IshidaMotohiro/RMeCab)
-   [junhewk/RcppMeCab: RcppMeCab: Rcpp Interface of CJK Morpheme
    Analyzer MeCab](https://github.com/junhewk/RcppMeCab)

## License

MIT license.

This software includes works that are distributed in Public Domain and
New BSD License. See
<https://github.com/takscape/cmecab-java/blob/master/README.txt> for
more details.

Icons made by [Vectors
Market](https://www.flaticon.com/authors/vectors-market) from
[Flaticon](https://www.flaticon.com/).
