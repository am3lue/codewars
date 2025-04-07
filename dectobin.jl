function dectobin(number::Int )
    value = []
    while number > 0
        push!(value,number % 2)
        number = div(number,2)
    end

    return join(reverse!(value), " ")
end

function dectooct(number::Int)
    value = []
    while number > 0
        push!(value, number % 8)
        number = div(number, 8)
    end

    return join(reverse!(value), " ")
end
println("""
Please Enter what you wanna do:
1. Decimal to Binary
2. Decimal to Octal
3. Decimal to Hexadecimal
4. Binary to Decimal
5. Octal to Decimal
6. Hexadecimal to Decimal
7. Exit
""")

while true
    choice = parse(Int,readline())
    if choice == 1
        println("Enter the number")
        number = parse(Int,readline())
        println("the number in Binary is: ",dectobin(number))

    elseif choice == 2
        println("Enter the number")
        number = parse(Int,readline())
        println("The number in octal is:",dectooct(number)) #for the color

    else
        println("Still Under Construction")
    end
end