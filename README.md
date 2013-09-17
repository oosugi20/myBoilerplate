# {%= project_name %}


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
