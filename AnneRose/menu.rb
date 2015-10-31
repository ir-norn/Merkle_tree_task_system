#coding:utf-8
# require "__dev/req" if $0 ==__FILE__
require"dxruby"

Window.loop do |o|

  Window.draw_font( 10,70, "-- menu --" , Font.default )
  Window.draw_font( 10,100, "テンキー 1 ... load block.rb( ブロック崩し )" , Font.default )
  Window.draw_font( 10,150, "テンキー 2 ... load menu.rb( このメニューシーン )" , Font.default )
  Window.draw_font( 10,200, "テンキー 3 ... load tree_view.rb( 現在のツリービューを表示 )" , Font.default )
  Window.draw_font( 10,250, "F4 Key ... 一つ上のノードへ" , Font.default )
  Window.draw_font( 10,300, "F9 Key ... 終了" , Font.default )

end
