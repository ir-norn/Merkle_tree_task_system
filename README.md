
### フレームワークv1

![https://cloud.githubusercontent.com/assets/13441384/10865791/815f8644-805b-11e5-89f3-b388e269d9a2.jpg](https://cloud.githubusercontent.com/assets/13441384/10865791/815f8644-805b-11e5-89f3-b388e269d9a2.jpg)

ファイル説明

root<br>
│  conf.rb　　設定<br>
│  Frederica.jpg　　フレデリカちゃん。<br>
│  index.rb　　色々require<br>
│  Merkle_default_class.rb　　どこのシーンに入っても実行されるデフォルト処理<br>
│  Merkle_tree.rb　　再帰ツリー<br>
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
処理の中核は`Merkle_tree.rb`と`tree_task.rb`<br>
`AnneRose`フォルダの中身を、それ単体で動くRubyスクリプトでありながら<br>
プロジェクトの１つのシーンとしても動く二面性を持たせる<br>
他にもあるけど一応こんなところ

**How to**

`AnneRose`フォルダの中がゲームとかの内容入れる場所で、ここにファイルを足していく


**TODO**

もうモチベが無ぃ
