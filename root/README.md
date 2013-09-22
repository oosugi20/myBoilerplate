# {%= project_name %}

`grunt archive` : `Gruntfile.js` などの開発用ファイルも含めたアーカイブをzip形式で吐き出す。
`grunt archive:htdocs` : `htdocs/` 内だけのアーカイブをzip形式で吐き出す。

# FTP

`.ftppass` というファイル名で以下の内容を記述したファイルを作成する。

```
{
  "{AUTHKEY_NAME}": {
    "username": "{USER_NAME}",
    "password": "{PASSWORD}"
  }
}
```

`deploy:zip` : `Gruntfile.js` などの開発用ファイルも含めたアーカイブをzip形式でFTPアップする。
`Gruntfile.js` の設定で、 `deploy:zip` 内に `archive:htdocs` も加えると、 `htdocs/` 内のみのzipもアップする。
加えて、 `deploy:zip` 内の `archive` を消すと、開発用ファイルを含めたアーカイブは作られず、`htdocs/` 内のアーカイブのみ作られFTPアップされる。


# How to build

## 最初
`
    $ npm install
    $ grunt
`
必要なnpmモジュールがインストールされ、各種リソースファイルが展開される。


## 制作時
`
    $ grunt watch
`
sassとjsを監視して変更があった場合に自動で展開する。

- `$ grunt watch:sass`: sassファイルのみ監視、展開
- `$ grunt watch:js`: jsファイルのみ監視、展開


## リリース時
`
    $ grunt build_release
`
前述の方法では、デバッグのにminifyされていないファイルを展開する。
このタスクを実行した場合は、minifyされたファイルが展開される。
