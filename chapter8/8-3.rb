def even?(n)
  if n == 0
    true
  else
    odd?(n - 1)
  end
end

def odd?(n)
  if n == 0
    false
  else
    even?(n - 1)
  end
end

i = 1
while i < 30
  p(even?(i))
  i = i + 1
end
