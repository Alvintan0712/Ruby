def getDecode(s)
    n = s.size()
    dp = Array.new(n, 0)
    
    if (s[0] == '0') 
        return 0
    end
    dp[0] = 1

    if (n == 1) 
        return 1
    end

    x = s[0,2].to_i
    if (0 <= x and x <= 26 and s[1] != '0') 
        dp[1] = 2
    elsif (0 <= x and x <= 26 and s[1] == '0') 
        dp[1] = 1
    elsif (s[1] != '0') 
        dp[1] = 1
    else 
        dp[1] = 0
    end

    for i in 2...n
        if (s[i] == '0') 
            if (s[i - 1] == '0')
                return 0
            end
            x = s[i - 1,2].to_i
            if (0 <= x and x <= 26) 
                dp[i] = dp[i - 2]
            end
        else
            dp[i] = dp[i - 1]
            x = s[i - 1,2].to_i
            if (0 <= x and x <= 26 and s[i - 1] != '0') 
                dp[i] += dp[i - 2]
            end
        end
    end

    return dp[n - 1]
end

def testdecode
    for i in 1..5000
        s = i.to_s
        # puts s
        puts getDecode(s)
    end
end

while inp = gets
    puts getDecode(inp.strip)
end
