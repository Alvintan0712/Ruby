def p(n)
  ans = 1
  if n < 10
    return n
  end

  while n > 0 do
    x = n % 10
    if x > 0
      ans *= x
    end
    n /= 10
  end
  
  return ans
end

def isPrime(n)
  if n < 2
    return false
  elsif n == 2
    return true
  end

  for i in 2.upto(n - 1)
    if i*i > n
      break
    end
    if n % i == 0
      return false
    end
  end

  return true
end

def primeFactor(n)
  res = 1
  if isPrime(n) 
    return n
  end
  while n > 1 do
    for x in 2..n
      if n % x == 0 and isPrime(x)
        res = x
        break
      end
    end
    n /= res
  end
  return res
end

def mfp(m)
  res = 0
  for n in 1.upto(m)
    res += p n
  end
  # puts "sum = #{res}"
  return primeFactor(res)
end

def testp
  for i in 1..100
    puts "#{ i }: #{ p i }"
  end
end

def testprime
  for i in 1..100
    puts "#{ i }: #{ isPrime i }"
  end
end

def testmfp
  for i in 1..10000
    res = mfp i
    puts "#{res}"
  end
end

# testmfp
puts mfp(1)
puts mfp(9999)
puts mfp(10000)
puts mfp(1000000)
