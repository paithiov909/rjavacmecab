# rjavacmecab <img src='man/figures/logo.png' align="right" height="139" />

[![GitHub last commit](https://img.shields.io/github/last-commit/paithiov909/rjavacmecab)](#) [![Build Status](https://travis-ci.com/paithiov909/rjavacmecab.svg?branch=master)](https://travis-ci.com/paithiov909/rjavacmecab) [![GitHub license](https://img.shields.io/github/license/paithiov909/rjavacmecab)](https://github.com/paithiov909/rjavacmecab/blob/master/LICENSE) [![Open Source Love](https://badges.frapsoft.com/os/v1/open-source.svg?v=103)](https://github.com/ellerbrock/open-source-badges/)


> rJava Interface to CMeCab

## Installation

```R
remotes::install_github("paithiov909/rjavacmecab")
```

## Requirements

- MeCab
- JDK

## Usage

```R
> rjavacmecab::cmecab_c("キャピキャピ音が高くなってきたら、ほんとに出してくれの合図です！　しっかりここではコミュニケーションとってください")
[[1]]
[1] "キャピキャピ 名詞,一般,*,*,*,*,*"

[[2]]
[1] "音 名詞,接尾,一般,*,*,*,音,オン,オン"

[[3]]
[1] "が 助詞,格助詞,一般,*,*,*,が,ガ,ガ"

[[4]]
[1] "高く 形容詞,自立,*,*,形容詞・アウオ段,連用テ接続,高い,タカク,タカク"

[[5]]
[1] "なっ 動詞,自立,*,*,五段・ラ行,連用タ接続,なる,ナッ,ナッ"

[[6]]
[1] "て 助詞,接続助詞,*,*,*,*,て,テ,テ"

[[7]]
[1] "き 動詞,非自立,*,*,カ変・クル,連用形,くる,キ,キ"

[[8]]
[1] "たら 助動詞,*,*,*,特殊・タ,仮定形,た,タラ,タラ"

[[9]]
[1] "、 記号,読点,*,*,*,*,、,、,、"

[[10]]
[1] "ほんとに 副詞,一般,*,*,*,*,ほんとに,ホントニ,ホントニ"

[[11]]
[1] "出し 動詞,自立,*,*,五段・サ行,連用形,出す,ダシ,ダシ"

[[12]]
[1] "て 助詞,接続助詞,*,*,*,*,て,テ,テ"

[[13]]
[1] "くれ 動詞,非自立,*,*,一段・クレル,連用形,くれる,クレ,クレ"

[[14]]
[1] "の 助詞,連体化,*,*,*,*,の,ノ,ノ"

[[15]]
[1] "合図 名詞,サ変接続,*,*,*,*,合図,アイズ,アイズ"

[[16]]
[1] "です 助動詞,*,*,*,特殊・デス,基本形,です,デス,デス"

[[17]]
[1] "！ 記号,一般,*,*,*,*,！,！,！"

[[18]]
[1] "　 記号,空白,*,*,*,*,　,　,　"

[[19]]
[1] "しっかり 副詞,助詞類接続,*,*,*,*,しっかり,シッカリ,シッカリ"

[[20]]
[1] "ここ 名詞,代名詞,一般,*,*,*,ここ,ココ,ココ"

[[21]]
[1] "で 助詞,格助詞,一般,*,*,*,で,デ,デ"

[[22]]
[1] "は 助詞,係助詞,*,*,*,*,は,ハ,ワ"

[[23]]
[1] "コミュニケーション 名詞,一般,*,*,*,*,コミュニケーション,コミュニケーション,コミュニケーション"

[[24]]
[1] "とっ 動詞,自立,*,*,五段・ラ行,連用タ接続,とる,トッ,トッ"

[[25]]
[1] "て 助詞,接続助詞,*,*,*,*,て,テ,テ"

[[26]]
[1] "ください 動詞,非自立,*,*,五段・ラ行特殊,命令ｉ,くださる,クダサイ,クダサイ"

[[27]]
[1] "EOS"
```

## Related repositories

- [takscape/cmecab-java: A Java binding for MeCab](https://github.com/takscape/cmecab-java) (cmecab-java)
- [s-u/rJava: R to Java interface](https://github.com/s-u/rJava) (rJava)
- [ikegami-yukino/mecab: Yet another Japanese morphological analyzer](https://github.com/ikegami-yukino/mecab) (MeCab 野良ビルド)

## License

MIT license. Icons made by [Vectors Market](https://www.flaticon.com/authors/vectors-market) from [Flaticon](https://www.flaticon.com/).

This software includes the works that are distributed in Public Domain and New BSD License. See https://github.com/takscape/cmecab-java/blob/master/README.txt for more details. 

