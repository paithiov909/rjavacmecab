
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rjavacmecab <a href='https://paithiov909.github.io/rjavacmecab'><img src='https://raw.githack.com/paithiov909/rjavacmecab/master/man/figures/logo.png' align="right" height="139" /></a>

<!-- badges: start -->

[![GitHub last
commit](https://img.shields.io/github/last-commit/paithiov909/rjavacmecab)](#)
[![Lifecycle:
maturing](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
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
res <- rjavacmecab::cmecab("キャピキャピ音が高くなってきたら、ほんとに出してくれの合図です！　しっかりここではコミュニケーションとってください")
str(res)
#> List of 1
#>  $ : chr [1:27] "キャピキャピ 名詞,一般,*,*,*,*,*" "音 名詞,接尾,一般,*,*,*,音,オン,オン" "が 助詞,格助詞,一般,*,*,*,が,ガ,ガ" "高く 形容詞,自立,*,*,形容詞・アウオ段,連用テ接続,高い,タカク,タカク" ...
```

### Prettify Output

``` r
res <- rjavacmecab::prettify(res)
print(res)
#>    sentence_id              token   POS1       POS2 POS3 POS4      X5StageUse1
#> 1            1       キャピキャピ   名詞       一般 <NA> <NA>             <NA>
#> 2            1                 音   名詞       接尾 一般 <NA>             <NA>
#> 3            1                 が   助詞     格助詞 一般 <NA>             <NA>
#> 4            1               高く 形容詞       自立 <NA> <NA> 形容詞・アウオ段
#> 5            1               なっ   動詞       自立 <NA> <NA>       五段・ラ行
#> 6            1                 て   助詞   接続助詞 <NA> <NA>             <NA>
#> 7            1                 き   動詞     非自立 <NA> <NA>       カ変・クル
#> 8            1               たら 助動詞       <NA> <NA> <NA>         特殊・タ
#> 9            1                 、   記号       読点 <NA> <NA>             <NA>
#> 10           1           ほんとに   副詞       一般 <NA> <NA>             <NA>
#> 11           1               出し   動詞       自立 <NA> <NA>       五段・サ行
#> 12           1                 て   助詞   接続助詞 <NA> <NA>             <NA>
#> 13           1               くれ   動詞     非自立 <NA> <NA>     一段・クレル
#> 14           1                 の   助詞     連体化 <NA> <NA>             <NA>
#> 15           1               合図   名詞   サ変接続 <NA> <NA>             <NA>
#> 16           1               です 助動詞       <NA> <NA> <NA>       特殊・デス
#> 17           1                 ！   記号       一般 <NA> <NA>             <NA>
#> 18           1                 　   記号       空白 <NA> <NA>             <NA>
#> 19           1           しっかり   副詞 助詞類接続 <NA> <NA>             <NA>
#> 20           1               ここ   名詞     代名詞 一般 <NA>             <NA>
#> 21           1                 で   助詞     格助詞 一般 <NA>             <NA>
#> 22           1                 は   助詞     係助詞 <NA> <NA>             <NA>
#> 23           1 コミュニケーション   名詞       一般 <NA> <NA>             <NA>
#> 24           1               とっ   動詞       自立 <NA> <NA>       五段・ラ行
#> 25           1                 て   助詞   接続助詞 <NA> <NA>             <NA>
#> 26           1           ください   動詞     非自立 <NA> <NA>   五段・ラ行特殊
#>    X5StageUse2           Original              Yomi1              Yomi2
#> 1         <NA>               <NA>               <NA>               <NA>
#> 2         <NA>                 音               オン               オン
#> 3         <NA>                 が                 ガ                 ガ
#> 4   連用テ接続               高い             タカク             タカク
#> 5   連用タ接続               なる               ナッ               ナッ
#> 6         <NA>                 て                 テ                 テ
#> 7       連用形               くる                 キ                 キ
#> 8       仮定形                 た               タラ               タラ
#> 9         <NA>                 、                 、                 、
#> 10        <NA>           ほんとに           ホントニ           ホントニ
#> 11      連用形               出す               ダシ               ダシ
#> 12        <NA>                 て                 テ                 テ
#> 13      連用形             くれる               クレ               クレ
#> 14        <NA>                 の                 ノ                 ノ
#> 15        <NA>               合図             アイズ             アイズ
#> 16      基本形               です               デス               デス
#> 17        <NA>                 ！                 ！                 ！
#> 18        <NA>                 　                 　                 　
#> 19        <NA>           しっかり           シッカリ           シッカリ
#> 20        <NA>               ここ               ココ               ココ
#> 21        <NA>                 で                 デ                 デ
#> 22        <NA>                 は                 ハ                 ワ
#> 23        <NA> コミュニケーション コミュニケーション コミュニケーション
#> 24  連用タ接続               とる               トッ               トッ
#> 25        <NA>                 て                 テ                 テ
#> 26      命令ｉ           くださる           クダサイ           クダサイ
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
#>   doc_id
#> 1      1
#>                                                                                                                                          text
#> 1 キャピキャピ 音 が 高く なっ て き たら 、 ほんとに 出し て くれ の 合図 です ！ 　 しっかり ここ で は コミュニケーション とっ て ください
```

### Change Dictionary

``` r
str <- "きゃりーぱみゅぱみゅ"
rjavacmecab::cmecab(str)
#> [[1]]
#> [1] "きゃ 動詞,非自立,*,*,五段・カ行促音便,仮定縮約１,く,キャ,キャ"
#> [2] "り 助動詞,*,*,*,文語・リ,基本形,り,リ,リ"                     
#> [3] "ー 名詞,固有名詞,一般,*,*,*,*"                                
#> [4] "ぱみゅぱみゅ 名詞,一般,*,*,*,*,*"                             
#> [5] "EOS"
rjavacmecab::cmecab(str, "-d /MeCab/ipadic-neologd")
#> [[1]]
#> [1] "きゃりーぱみゅぱみゅ 名詞,固有名詞,人名,一般,*,*,きゃりーぱみゅぱみゅ,キャリーパミュパミュ,キャリーパミュパミュ"
#> [2] "EOS"
```

## Related Products

-   [IshidaMotohiro/RMeCab: Interface to
    MeCab](https://github.com/IshidaMotohiro/RMeCab)
-   [junhewk/RcppMeCab: RcppMeCab: Rcpp Interface of CJK Morpheme
    Analyzer MeCab](https://github.com/junhewk/RcppMeCab)

## Code of Conduct

Please note that the rjavacmecab project is released with a [Contributor
Code of
Conduct](https://paithiov909.github.io/rjavacmecab/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.

## Licenses

MIT license.

This software includes works that are distributed in Public Domain and
New BSD License. See
<https://github.com/takscape/cmecab-java/blob/master/README.txt> for
more details.

Icons made by [Vectors
Market](https://www.flaticon.com/authors/vectors-market) from
[Flaticon](https://www.flaticon.com/).
