
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


---

**コンセプト**

再帰ツリーで書かれたタスクシステムを記述する事<br>
`AnneRose`フォルダの中身を、それ単体で動くRubyスクリプトでありながら<br>
ゲーム全体プロジェクトの１つのシーンとしても動く二面性を持たせる<br>
他にもあるけど一応こんなところ

**How to**

`AnneRose`フォルダの中がゲームとかの内容になる<br>
シーン間の移動は、とりあえず Merkle_default_class.rb : Line21
```ruby
@node_self.Flandoll << :block         if Input.keyPush? K_1
@node_self.Flandoll << :menu          if Input.keyPush? K_2
@node_self.Flandoll << :tree_view     if Input.keyPush? K_3
```

この辺で制御、テンキーの１，２，３<br>



**TODO**

シーン間のデータのやり取りの方法が曖昧<br>
`ARGV.replace [ 1, 2 ]`で送るって案が今のところ有力<br>
