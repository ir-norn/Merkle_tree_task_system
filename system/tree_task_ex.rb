#coding:utf-8
# require "__dev/req" if $0 ==__FILE__

# --- ユーティリティ ---

module Merkle_tree_m_ex
  def TOP_NODE
    return up.up.TOP_NODE if up.up
    self
  rescue
    self
  end
  def TOP_SYM
    self.TOP_NODE.sym
  end
  def delete
    if up
      up.task.delete self
      task.clear
    end
  end
# selfより上の一番近い nodeを返す
  def search_up sym
    return self if self.sym =~ /#{sym}/
    return up.search_up sym if up
    false
  end

end
