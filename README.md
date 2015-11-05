
### フレームワークv1

![https://cloud.githubusercontent.com/assets/13441384/10865791/815f8644-805b-11e5-89f3-b388e269d9a2.jpg](https://cloud.githubusercontent.com/assets/13441384/10865791/815f8644-805b-11e5-89f3-b388e269d9a2.jpg)

ファイル説明

root<br>
│  conf.rb　　設定<br>
│  Frederica.jpg　　フレデリカちゃん。<br>
│  index.rb　　色々require<br>
├─project<br>
│　　Merkle_default_class.rb　　どこのシーンに入っても実行されるデフォルト処理<br>
│　　Merkle_tree.rb　　再帰ツリー<br>
│<br>
├─AnneRose<br>
│　　loading.rb　　シーン入る前のロード画面<br>
│　　menu.rb　　メニューシーン<br>
│　　dot.rb　　sample<br>
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
`AnneRose`フォルダの中身を、それ単体で動くdxRubyアプリでありながら<br>
プラグインとしても動く二面性を持たせる<br>
他にもあるけど一応こんなところ

**How to**

`AnneRose`フォルダの中がゲームとかの内容入れる場所で、ここにファイルを足していく


**TODO**

もうモチベが無ぃ



---
tree.task.rb
```ruby
module Merkle_tree_m
  attr_accessor :sym , :up , :func , :task
  def initialize sym: nil , up: nil , &proc
    @sym      = sym
    @up       = up
    @func     = proc
    @task     = []
  end
  def _taskloop
    task.each do | b | b.func = b.func[b].func end
  end
  def Main sym
    Task sym , &proc
    nil while not _taskloop.empty?
  end
  def Task sym = :task
    task << self.class.new(sym:sym , up:self , &proc)
  end
  def Code
    self.class.new do
      yield
      _taskloop
      self
    end
  end
end
```

---

Merkle_tree.rb
```ruby
class Merkle_tree
  include Merkle_tree_m
  include Merkle_tree_m_ex
  include DEBUG_CODE_m
  attr_accessor :Flandoll , :Scarlet
  def initialize **_
    super
    @Flandoll = []
    @Scarlet  = Hash.new
  end
end

Merkle_tree.new.Main :__merkle_tree_main_top_node do |o|
  o.Code do
    if o.task.empty? then o.Flandoll << :tree_view
    end
    -> &b do lambda do |f|
        lambda{|x|lambda{|y| f[x[x]] [y]}}[
          lambda{|x|lambda{|y| f[x[x]] [y]}}]
      end[ lambda{|f|lambda{|n| b[n , &f] }}]
    end.yield do | ( o , rb ) , &f |
      case o.Flandoll.shift
      when nil then true
      when -> rb do Merkle_tree.loading o , rb end
      when -> rb do
          o.Task :"__#{rb}_task" do |o|
            o.Code do
              o.Main :"#{rb}" do |o|
                Merkle_scene.new o , rb
                o.Code do
                  f[ [o , rb] ]
                end # code
              end # main
            end # co
          end # tas
        end #lm
      end # case
    end[ [ o , nil ] ] # recursion
  end # code do
end # main
```


---

追記、2015 11 04

オブジェクト指向以外からのアプローチで設計を書く試み...<br>


ここで使ってる用語の意味<br>
1. ノード( node )：`Merkle_tree`以下にあるすべてのノード<br>
2. シーン( scene )：`Merkle_tree`以下にあるノードの中からメッセージループを持つもの<br>
3. オブジェクト( object )：`Merkle_tree`以下にあるノードの中からメッセージループを持たないもの<br>

***シーン生成 flow***

<a class="blog_img" href="http://ir-norn.github.io/images/flow_scene.jpg" title="flow">
![http://ir-norn.github.io/./images/flow_scene.jpg](http://ir-norn.github.io/./images/flow_scene.jpg)
</a>

`Window.loop do ... end`でシーンを個別に作る<br>
それを`Merkle_tree`(本番環境)へ、ノードとして生成し、<br>
各シーンの起動に必要な引数はARGVに格納することを規約にして、<br>
個別開発の時にはこれが最低限のテンプレート<br>

```ruby
#coding:utf-8
require "dxruby"
if $0 == __FILE__
  ARGV.replace [ [ 1 , 2 ] ] # テストデータ
else
  argv = ARGV.shift  # 本番環境はこちらから引数を取得
end

Window.loop do

end
```

通常の`dxruby`のように書いていける<br>
でも`Window.loop`が本番環境ではフックされるので<br>
定数`Window`周りは、とりあえず触らない方向で<br>
これらのファイルは`eval`ではなく、`load "file" , true` で<br>
ノード生成のタイミングで読み込まれる

---

既存のノードから新規ノードへの引数受け渡しフォーマット<br>
`ARGV.replace [ *ARGV , [ 1 , 2 ] ]`<br>

取り出し側<br>
`x , y = ARGV.shift`<br>

`:push :<<`ではなく`:replace`を使用してるのは<br>
現在の最新バージョン`ruby 2.2.3p173`にBUGがある為、<br>
そちらを使ってBUGの表面化を回避する<br>

---

***オブジェクト生成 flow***

上記の開発フローの仕組みを<br>
オブジェクト単位でも行う図 ↓

<a class="blog_img" href="http://ir-norn.github.io/images/flow_object.jpg" title="flow">
![http://ir-norn.github.io/./images/flow_object.jpg](http://ir-norn.github.io/./images/flow_object.jpg)
</a>

ノードとして生成した場合は`Merkle_tree`のメソッド<br>
ツリー探索、削除などが使える<br>
ツリーでなくても良い場合や、<br>
オブジェクトから`Merklt_tree`のリソースにアクセスしない場合は<br>
オブジェクトをノードとして生成しなくても記述出来る

---

***全体図***

Project関係のものは全部AnneRoseフォルダの中に入れる。<br>
img , sound とかも。<br>
この`tree_task.rb`や`Merkle_tree.rb`はbase systemの部類。<br>
ゲームのタスクに限らず、ゲーム以外にもあらゆるタスクを書く事を想定していて、<br>
ライブラリよりも上位なので、Libフォルダには含めない。<br>

<a class="blog_img" href="http://ir-norn.github.io/images/entire_flow.jpg" title="flow">
![http://ir-norn.github.io/./images/entire_flow.jpg](http://ir-norn.github.io/./images/entire_flow.jpg)
</a>
