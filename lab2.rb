def getbin(x)
    cnt = 0
    while x > 0
        cnt += x & 1
        x >>= 1
    end
    return cnt
end

def testbin()
    for x in 1..100
        puts "#{x} : #{getbin(x)}"
    end
end

# testbin

x = gets.to_i
puts getbin(x)
