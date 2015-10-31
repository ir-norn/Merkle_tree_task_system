
### DxRubyフレームワークv1

![https://cloud.githubusercontent.com/assets/13441384/10865791/815f8644-805b-11e5-89f3-b388e269d9a2.jpg](https://cloud.githubusercontent.com/assets/13441384/10865791/815f8644-805b-11e5-89f3-b388e269d9a2.jpg)

ファイル説明

root<br>
│  conf.rb　　設定<br>
│  Frederica.jpg　　フレデリカちゃん。<br>
│  index.rb　　色々require<br>
│  Merkle_default_class.rb　　どこのシーンに入っても実行されるデフォルト処理<br>
│  Merkle_tree.rb　　再帰ツリー<br>
│  rakefile　　rake command<br>
│  README.md　　このファイル<br>
│<br>
├─AnneRose<br>
│　　loading.rb　　シーン入る前のロード画面<br>
│　　menu.rb　　メニューシーン<br>
│　　block.rb　　ブロック崩し?<br>
│　　tree_view.rb　　現在のツリー階層を表示<br>
│<br>
└─system<br>
│　　debug.rb　　デバッグ用<br>
│　　tree_task.rb　　Merkle_treeを作るのに必要なタスクシステム<br>
│　　tree_task_ex.rb　　それの拡張<br>
│<br>
└─dev_req<br>
　   　　req.rb　rubyのPATH通した場所におくとindex.rb以外からも実行できるようにするファイル<br>


---

**コンセプト**

dxrubyフレームワークって書いたけど、どのライブラリに依存しないように<br>
ツリーで書かれたタスクシステムのみを記述する事<br>
`AnneRose`フォルダの中身を、それ「単体で動く」Rubyスクリプトでありながら<br>
ゲーム全体プロジェクトの「１つのシーン」としても動く二面性を持たせて<br>
それらのシーン管理システムをツリーノードとして扱う事でコード量の圧縮<br>

**How to**

ゲ制作の為に変更していくファイルは<br>
`AnneRose`フォルダの中と<br>
`Merkle_default_class.rb`と<br>
`conf.rb`だけ<br>

シーン間の移動は、暫定的だけど、
とりあえず Merkle_default_class.rb : Line21
```ruby
@node_self.Flandoll << :block         if Input.keyPush? K_1
@node_self.Flandoll << :menu          if Input.keyPush? K_2
@node_self.Flandoll << :tree_view     if Input.keyPush? K_3
```

この辺で制御、テンキーの１，２，３<br>
`@node_self.Flandoll`　に次シーンの「拡張子をのぞいたファイル名」を<br>
シンボルとしてpushする<br>
同じシーンの積み重ねも可能<br>
積み重ねというより、再帰で潜っていくイメージだけど・・・その場合、状態を保持したまま新しいインスタンスを生成<br>
`@node_self`または o は、ツリーのノードを示す。<br>
ツリーゆえにかなり複雑に変異する変数なので<br>
p o.sym とかで頻繁にシンボル表示させながらコード書かないと無理<br>
あと変数Scarletは今のこと未使用（シーン間のデータやり取りに使うかどうか)

あと、`Window.loop do |o|`の o は`index.rb`から起動した場合と<br>
AnneRoseフォルダから起動した場合で、別のオブジェクトが入っています<br>
`if $0 == __FILE__` とかで処理分けが必要


**問題点**

- `Window.loop`を`Merkle_default_class.rb`が一時的に<br>
オーバーライドしている為、`Window.loop`の２回以上の呼び出しは出来ない(dxruby1.5系出たら問題になるかも)<br>
- rubyが再帰遅い


**TODO**

シーン間のデータのやり取りの方法を考え中<br>
`ARGV.replace [ 1, 2 ]`で送るって案が今のところ有力<br>
