# rjavacmecab 0.4.1.900

* Memoise `read_rewrite_def`.

# rjavacmecab 0.4.1

* Added a `NEWS.md` file to track changes to the package.
* Added 'Gibasa' function family (experimental).
* Clean package dependencies.
* `pack(n = 1L)`のときには`ngram_tokenizer`を使用しないように修正
* `cmecab`の挙動の変更
  * `mode ="wakati"`を追加
  * `mode = "parse"`で`"EOS"`を出力しないように修正
  * `cmecab(split = FALSE)`に名前付きベクトルを与えた際、戻り値に名前を保持する

# rjavacmecab 0.4.0

* Igo (v0.4.5) を利用する関数を追加
* 辞書ファイルの管理をGit LFSから通常のbinaryに変更 (patched)
* `cmecab`, `igo`に文区切りのオプションを追加 (patched)
* CSVUtilのAPIを利用する関数名を変更 (patched)
