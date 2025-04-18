def fib(x)
  if x < 2
    x
  else
    fib(x - 1) + fib(x - 2)
  end
end

i = 1
while i < 30
  p(fib(i))
  i = i + 1
end
