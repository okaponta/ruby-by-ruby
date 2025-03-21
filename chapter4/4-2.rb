require "minruby"

def max(tree)
  if tree[0] == "lit"
    return tree[1]
  end
  left = max(tree[1])
  right = max(tree[2])
  if left < right
    right
  else
    left
  end
end

str = gets
tree = minruby_parse(str)
answer = max(tree)
p(answer)
