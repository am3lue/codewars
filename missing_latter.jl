function findmissingletter(arr::Array{Char})
    for c in arr
        if c == 'c'
            return  c += 1
        end
  end
end

arr = ['a','b','c','d']
println(findmissingletter(arr))