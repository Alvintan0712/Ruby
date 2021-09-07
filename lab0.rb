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
    if n % i == 0
      return false
    end
  end

  return true
end

$n = 531441
$prime = Array.new($n + 1, 0)
def buildPrimeTable
  len = 0
  visit = Array.new($n + 1, false)

  for i in 2..$n
    if not visit[i]
      $prime[len] = i
      len += 1
    end
    for j in 0..len - 1
      if (i*$prime[j] > $n) 
        break
      end
      visit[i*$prime[j]] = true
      if (i % $prime[j] == 0) 
        break
      end
    end
  end
end

def primeFactor(n)
  res = 1
  for x in $prime
    if x > n or x == 0
      break
    end
    if n % x == 0
      res = x
    end
  end
  return res
end

def mfp(m)
  res = 0
  for n in 1.upto(m)
    res += p n
  end

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
  for i in 1..100
    sum, res = mfp i
    puts "#{i}: #{res}"
  end
end

buildPrimeTable

puts mfp(1)
puts mfp(9999)
puts mfp(10000)
puts mfp(1000000)
