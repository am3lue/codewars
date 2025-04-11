function gcf(a, b)
    for i in 1:min(a ,b)
        if a % i == 0 && b % i == 0
            gcf  = i
        end
    end
    return gcf
end

println(gcf(readlinst(stdin)[1], readlines(stdin)[2]))