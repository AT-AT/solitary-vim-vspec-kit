# solitary-vim-vspec-kit

[vim-vspec](https://github.com/kana/vim-vspec) を [vim-flavor](https://github.com/kana/vim-flavor) を使用せずに導入するための自分向けの手順とファイル一式。

## 利用元ソース

* vim-vspec 1.6.1

## 導入手順

1. vim-vspecフォルダをそのままvim本体へプラグインとしてインストール（初回のみ）
1. コンソールから実行されるvimがテスト対象のvimであるかを確認（初回のみ）
  * 対象のVimは `/Applications/MacVim.app/Contents/MacOS/Vim` となる。
  * aliasの設定や、環境変数PATHへの追加はテスト時には影響しないため、シンボリックリンクを設置する。
  ```sh
  mv /usr/bin/vim /usr/bin/vim.system
  ln -s /Applications/MacVim.app/Contents/MacOS/Vim /usr/bin/vim
  ```
  * なお10.11では、一度SIPを無効にしてから上記設定を行い、再度有効にしておく。
1. Gemfile / Rakefile / tフォルダ / vendorフォルダをテスト対象プラグインフォルダ内へコピー
1. テストに必要なGemをプラグインフォルダへインストール
```sh
bundle install --path vendor/bundle
```

## テスト実行

1. tフォルダ内へテストファイルを用意
1. `bundle exec rake test`

## テストを作成する場合のメモ

* tディレクトリ直下にあるファイルのみテストとしてロードされ、サブディレクトリ以下は対象にならない。
* tディレクトリと同階層にあるautoloadディレクトリはruntimepathに入っているため、テストファイル内でautoload以下のファイルをロードする必要は無い。
* pluginディレクトリ内のファイルは、テストファイル内で読み込み必要がある（t/sample.vimを参照）。
* VimEnterイベントは起こらないため、それに紐付いた初期化ロジックはテスト内で明示的に実行する必要がある。

* Expect式の中では、テストローカルな関数にはアクセスできない。
* スクリプトローカルな変数や関数をテストする場合は、テスト対象となるファイルにパブリックなヘルパー関数を定義し、vspec#hint()で指定する必要がある（t/sample.vimを参照）。
* Ref()関数は辞書形式変数へのドットアクセスを処理できない。
```vim
" NG
call Ref('s:foo.bar')
" OK
call (Ref('s:foo'))['bar']
```

## vim-vspecアップデート時の対応メモ

1. vim-vspecフォルダ内の対応するファイル・フォルダを上書き
1. vendor/vim-vspecフォルダ内の対応するファイル・フォルダを上書き
1. 対応するrspecのバージョンに変更があった場合はGemfileを変更

## テストライブラリのインストール先についてのメモ

* autoload/vspec.vimは、プラグインとしてvimへインストールして、bin/prove-vspecの実行時にパス（例えば、~/vim/bundle/vim-vspecなど）を渡すことで、テスト対象のプラグインフォルダ内に不要となるが、vim-vspecのバージョンアップによる後方互換性の喪失に備えて独立させる。
* rspec他のGemについても同様。

## 参考リソース

* [Vim プラグイン開発でもユニットテストがしたい! (vim-vspec 編) - TIM Labs](http://labs.timedia.co.jp/2013/02/vim-vspec-introduction.html)
* [An introduction to vspec](http://vimcasts.org/episodes/an-introduction-to-vspec/)
* [vim-textobj-userのテスト](https://github.com/kana/vim-textobj-user/tree/master/t)
* [vim-vspecのテスト](https://github.com/kana/vim-vspec/tree/master/t)
* [vim-vspecのドキュメント](https://github.com/kana/vim-vspec/blob/master/doc/vspec.txt)

