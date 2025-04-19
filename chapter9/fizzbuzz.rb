i = 0
p(i)
p("FizzBuzz")
while i < 100
    if i % 15 == 0
        p("FizzBuzz")
    else
        if i % 3 == 0
            p("Fizz")
        else
            if i % 5 == 0
                p("Buzz")
            else
                p(i)
            end
        end
    end
    i = i + 1
end
