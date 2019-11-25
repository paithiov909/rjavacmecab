# rjavacmecab

[![GitHub last commit](https://img.shields.io/github/last-commit/paithiov909/rjavacmecab)](#) [![GitHub license](https://img.shields.io/github/license/paithiov909/rjavacmecab)](https://github.com/paithiov909/rjavacmecab/blob/master/LICENSE)

rJava Interface to CMeCab

## Installation

```R
remotes::install_github("paithiov909/rjavacmecab")
```

## Requirements

- MeCab
- JRE

## Usage

```R
> rjavacmecab::cmecab_c("やれやれとボッタリくつろぐ鶏肉に上からいくつかかけ流していきます")
[[1]]
[1] "やれやれ 感動詞,*,*,*,*,*,やれやれ,ヤレヤレ,ヤレヤレ"

[[2]]
[1] "と 助詞,格助詞,引用,*,*,*,と,ト,ト"

[[3]]
[1] "ボッタリ 名詞,一般,*,*,*,*,*"

[[4]]
[1] "くつろぐ 動詞,自立,*,*,五段・ガ行,基本形,くつろぐ,クツログ,クツログ"

[[5]]
[1] "鶏肉 名詞,一般,*,*,*,*,鶏肉,ケイニク,ケイニク"

[[6]]
[1] "に 助詞,格助詞,一般,*,*,*,に,ニ,ニ"

[[7]]
[1] "上 名詞,一般,*,*,*,*,上,ウエ,ウエ"

[[8]]
[1] "から 助詞,格助詞,一般,*,*,*,から,カラ,カラ"

[[9]]
[1] "いくつ 名詞,代名詞,一般,*,*,*,いくつ,イクツ,イクツ"

[[10]]
[1] "か 助詞,副助詞／並立助詞／終助詞,*,*,*,*,か,カ,カ"

[[11]]
[1] "かけ 動詞,自立,*,*,一段,連用形,かける,カケ,カケ"

[[12]]
[1] "流し 動詞,自立,*,*,五段・サ行,連用形,流す,ナガシ,ナガシ"

[[13]]
[1] "て 助詞,接続助詞,*,*,*,*,て,テ,テ"

[[14]]
[1] "いき 動詞,非自立,*,*,五段・カ行促音便,連用形,いく,イキ,イキ"

[[15]]
[1] "ます 助動詞,*,*,*,特殊・マス,基本形,ます,マス,マス"

[[16]]
[1] "EOS"
```



## Related repositories

- [takscape/cmecab-java: A Java binding for MeCab](https://github.com/takscape/cmecab-java)

## License

MIT license. 

This software includes the works that are distributed in Public Domain and new BSD License. See https://github.com/takscape/cmecab-java/blob/master/README.txt for more details. 

