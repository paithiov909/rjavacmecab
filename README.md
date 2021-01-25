
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rjavacmecab <a href='https://paithiov909.github.io/rjavacmecab'><img src='https://raw.githack.com/paithiov909/rjavacmecab/master/man/figures/logo.png' align="right" height="139" /></a>

<!-- badges: start -->

[![GitHub last
commit](https://img.shields.io/github/last-commit/paithiov909/rjavacmecab)](#)
[![Lifecycle:
maturing](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
[![Build
Status](https://travis-ci.com/paithiov909/rjavacmecab.svg?branch=master)](https://travis-ci.com/paithiov909/rjavacmecab)
[![Codecov test
coverage](https://codecov.io/gh/paithiov909/rjavacmecab/branch/master/graph/badge.svg)](https://codecov.io/gh/paithiov909/rjavacmecab?branch=master)
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
#> List of 27
#>  $ : chr "キャピキャピ 名詞,一般,*,*,*,*,*"
#>  $ : chr "音 名詞,接尾,一般,*,*,*,音,オン,オン"
#>  $ : chr "が 助詞,格助詞,一般,*,*,*,が,ガ,ガ"
#>  $ : chr "高く 形容詞,自立,*,*,形容詞・アウオ段,連用テ接続,高い,タカク,タカク"
#>  $ : chr "なっ 動詞,自立,*,*,五段・ラ行,連用タ接続,なる,ナッ,ナッ"
#>  $ : chr "て 助詞,接続助詞,*,*,*,*,て,テ,テ"
#>  $ : chr "き 動詞,非自立,*,*,カ変・クル,連用形,くる,キ,キ"
#>  $ : chr "たら 助動詞,*,*,*,特殊・タ,仮定形,た,タラ,タラ"
#>  $ : chr "、 記号,読点,*,*,*,*,、,、,、"
#>  $ : chr "ほんとに 副詞,一般,*,*,*,*,ほんとに,ホントニ,ホントニ"
#>  $ : chr "出し 動詞,自立,*,*,五段・サ行,連用形,出す,ダシ,ダシ"
#>  $ : chr "て 助詞,接続助詞,*,*,*,*,て,テ,テ"
#>  $ : chr "くれ 動詞,非自立,*,*,一段・クレル,連用形,くれる,クレ,クレ"
#>  $ : chr "の 助詞,連体化,*,*,*,*,の,ノ,ノ"
#>  $ : chr "合図 名詞,サ変接続,*,*,*,*,合図,アイズ,アイズ"
#>  $ : chr "です 助動詞,*,*,*,特殊・デス,基本形,です,デス,デス"
#>  $ : chr "！ 記号,一般,*,*,*,*,！,！,！"
#>  $ : chr "　 記号,空白,*,*,*,*,　,　,　"
#>  $ : chr "しっかり 副詞,助詞類接続,*,*,*,*,しっかり,シッカリ,シッカリ"
#>  $ : chr "ここ 名詞,代名詞,一般,*,*,*,ここ,ココ,ココ"
#>  $ : chr "で 助詞,格助詞,一般,*,*,*,で,デ,デ"
#>  $ : chr "は 助詞,係助詞,*,*,*,*,は,ハ,ワ"
#>  $ : chr "コミュニケーション 名詞,一般,*,*,*,*,コミュニケーション,コミュニケーション,コミュニケーション"
#>  $ : chr "とっ 動詞,自立,*,*,五段・ラ行,連用タ接続,とる,トッ,トッ"
#>  $ : chr "て 助詞,接続助詞,*,*,*,*,て,テ,テ"
#>  $ : chr "ください 動詞,非自立,*,*,五段・ラ行特殊,命令ｉ,くださる,クダサイ,クダサイ"
#>  $ : chr "EOS"
```

### Prettify Output

``` r
res <- rjavacmecab::prettify(res)
print(res)
#>               Surface   POS1       POS2 POS3 POS4      X5StageUse1 X5StageUse2
#> 1        キャピキャピ   名詞       一般 <NA> <NA>             <NA>        <NA>
#> 2                  音   名詞       接尾 一般 <NA>             <NA>        <NA>
#> 3                  が   助詞     格助詞 一般 <NA>             <NA>        <NA>
#> 4                高く 形容詞       自立 <NA> <NA> 形容詞・アウオ段  連用テ接続
#> 5                なっ   動詞       自立 <NA> <NA>       五段・ラ行  連用タ接続
#> 6                  て   助詞   接続助詞 <NA> <NA>             <NA>        <NA>
#> 7                  き   動詞     非自立 <NA> <NA>       カ変・クル      連用形
#> 8                たら 助動詞       <NA> <NA> <NA>         特殊・タ      仮定形
#> 9                  、   記号       読点 <NA> <NA>             <NA>        <NA>
#> 10           ほんとに   副詞       一般 <NA> <NA>             <NA>        <NA>
#> 11               出し   動詞       自立 <NA> <NA>       五段・サ行      連用形
#> 12                 て   助詞   接続助詞 <NA> <NA>             <NA>        <NA>
#> 13               くれ   動詞     非自立 <NA> <NA>     一段・クレル      連用形
#> 14                 の   助詞     連体化 <NA> <NA>             <NA>        <NA>
#> 15               合図   名詞   サ変接続 <NA> <NA>             <NA>        <NA>
#> 16               です 助動詞       <NA> <NA> <NA>       特殊・デス      基本形
#> 17                 ！   記号       一般 <NA> <NA>             <NA>        <NA>
#> 18                 　   記号       空白 <NA> <NA>             <NA>        <NA>
#> 19           しっかり   副詞 助詞類接続 <NA> <NA>             <NA>        <NA>
#> 20               ここ   名詞     代名詞 一般 <NA>             <NA>        <NA>
#> 21                 で   助詞     格助詞 一般 <NA>             <NA>        <NA>
#> 22                 は   助詞     係助詞 <NA> <NA>             <NA>        <NA>
#> 23 コミュニケーション   名詞       一般 <NA> <NA>             <NA>        <NA>
#> 24               とっ   動詞       自立 <NA> <NA>       五段・ラ行  連用タ接続
#> 25                 て   助詞   接続助詞 <NA> <NA>             <NA>        <NA>
#> 26           ください   動詞     非自立 <NA> <NA>   五段・ラ行特殊      命令ｉ
#>              Original              Yomi1              Yomi2
#> 1                <NA>               <NA>               <NA>
#> 2                  音               オン               オン
#> 3                  が                 ガ                 ガ
#> 4                高い             タカク             タカク
#> 5                なる               ナッ               ナッ
#> 6                  て                 テ                 テ
#> 7                くる                 キ                 キ
#> 8                  た               タラ               タラ
#> 9                  、                 、                 、
#> 10           ほんとに           ホントニ           ホントニ
#> 11               出す               ダシ               ダシ
#> 12                 て                 テ                 テ
#> 13             くれる               クレ               クレ
#> 14                 の                 ノ                 ノ
#> 15               合図             アイズ             アイズ
#> 16               です               デス               デス
#> 17                 ！                 ！                 ！
#> 18                 　                 　                 　
#> 19           しっかり           シッカリ           シッカリ
#> 20               ここ               ココ               ココ
#> 21                 で                 デ                 デ
#> 22                 は                 ハ                 ワ
#> 23 コミュニケーション コミュニケーション コミュニケーション
#> 24               とる               トッ               トッ
#> 25                 て                 テ                 テ
#> 26           くださる           クダサイ           クダサイ
```

If you use IPA-styled dictionary, the output has these columns.

-   Surface: 表層形
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
#>   Sid
#> 1   1
#>                                                                                                                                          Text
#> 1 キャピキャピ 音 が 高く なっ て き たら 、 ほんとに 出し て くれ の 合図 です ！ 　 しっかり ここ で は コミュニケーション とっ て ください
```

### Change Dictionary

``` r
str <- "きゃりーぱみゅぱみゅ"
rjavacmecab::cmecab(str)
#> [[1]]
#> [1] "きゃ 動詞,非自立,*,*,五段・カ行促音便,仮定縮約１,く,キャ,キャ"
#> 
#> [[2]]
#> [1] "り 助動詞,*,*,*,文語・リ,基本形,り,リ,リ"
#> 
#> [[3]]
#> [1] "ー 名詞,固有名詞,一般,*,*,*,*"
#> 
#> [[4]]
#> [1] "ぱみゅぱみゅ 名詞,一般,*,*,*,*,*"
#> 
#> [[5]]
#> [1] "EOS"
rjavacmecab::cmecab(str, "-d /MeCab/dic/mecab-ipadic-neologd")
#> [[1]]
#> [1] "きゃりーぱみゅぱみゅ 名詞,固有名詞,人名,一般,*,*,きゃりーぱみゅぱみゅ,キャリーパミュパミュ,キャリーパミュパミュ"
#> 
#> [[2]]
#> [1] "EOS"
```

## Related Products

-   [takscape/cmecab-java: A Java binding for
    MeCab](https://github.com/takscape/cmecab-java) (cmecab-java)
-   [s-u/rJava: R to Java interface](https://github.com/s-u/rJava)
    (rJava)
-   [ikegami-yukino/mecab: Yet another Japanese morphological
    analyzer](https://github.com/ikegami-yukino/mecab) (MeCab
    野良ビルド)

## Code of Conduct

Please note that the rjavacmecab project is released with a [Contributor
Code of
Conduct](https://paithiov909.github.io/rjavacmecab/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.

## License

Under the MIT license

Icons made by [Vectors
Market](https://www.flaticon.com/authors/vectors-market) from
[Flaticon](https://www.flaticon.com/).

This software includes works that are distributed in Public Domain and
New BSD License. See
<https://github.com/takscape/cmecab-java/blob/master/README.txt> for
more details.
