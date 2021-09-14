def getDecode(s)
    n = s.size()
    dp = Array.new(n + 1, 0)
    
    dp[n] = 1
    if (dp[n - 1] != '0') 
        dp[n - 1] = 1
    end

    for i in (n - 2).downto(0)
        if (s[i] != '0') 
            x = s[i,2].to_i
            if (1 <= x and x <= 26) 
                dp[i] += dp[i + 2]
            end
            dp[i] += dp[i + 1]
        end
    end

    return dp[0]
end

def testdecode
    for i in 1..5000
        s = i.to_s
        puts getDecode(s)
    end
end

inp = gets
puts getDecode(inp.strip)
