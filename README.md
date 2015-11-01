
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
