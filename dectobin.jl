function dectobin(number::Real)
    integer_part = floor(Int, number)
    decimal_part = number - integer_part
    
    # Handle integer part
    value = []
    temp = integer_part
    while temp > 0
        push!(value, temp % 2)
        temp = div(temp, 2)
    end
    if isempty(value)
        push!(value, 0)
    end
    
    # Handle decimal part
    decimal_bits = []
    precision = 10  # Number of decimal places to calculate
    i = 0
    while decimal_part > 0 && i < precision
        decimal_part *= 2
        bit = floor(Int, decimal_part)
        push!(decimal_bits, bit)
        decimal_part -= bit
        i += 1
    end
    
    # Combine results
    result = join(reverse!(value))
    if !isempty(decimal_bits)
        result *= "." * join(decimal_bits)
    end
    return result
end

function dectooct(number::Int)
    value = []
    while number > 0
        push!(value, number % 8)
        number = div(number, 8)
    end

    return join(reverse!(value), " ")
end

function dectohex(number::Int)
    value = []
    while number > 0
        remainder = number % 16
        if remainder > 9
            push!(value, Char(remainder - 10 + Int('A')))
        else
            push!(value, remainder)
        end
        number = div(number, 16)
    end
    
    return join(reverse!(value), " ")
end

function bintodec(binary::String)
    decimal = 0
    power = 0
    for digit in reverse(filter(c -> c != ' ', binary))
        decimal += parse(Int, digit) * (2 ^ power)
        power += 1
    end
    return decimal
end

function octtodec(octal::String)
    decimal = 0
    power = 0
    for digit in reverse(filter(c -> c != ' ', octal))
        decimal += parse(Int, digit) * (8 ^ power)
        power += 1
    end
    return decimal
end

function hextodec(hex::String)
    decimal = 0
    power = 0
    for digit in reverse(filter(c -> c != ' ', hex))
        if isdigit(digit)
            decimal += parse(Int, digit) * (16 ^ power)
        else
            decimal += (Int(uppercase(digit)) - Int('A') + 10) * (16 ^ power)
        end
        power += 1
    end
    return decimal
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
        number = parse(Float64,readline())
        println("the number in Binary is: ",dectobin(number))
    elseif choice == 2
        println("Enter the number")
        number = parse(Int,readline())
        println("The number in octal is:",dectooct(number))
    elseif choice == 3
        println("Enter the number")
        number = parse(Int,readline())
        println("The number in hexadecimal is:",dectohex(number))
    elseif choice == 4
        println("Enter the binary number")
        binary = readline()
        println("The decimal number is:",bintodec(binary))
    elseif choice == 5
        println("Enter the octal number")
        octal = readline()
        println("The decimal number is:",octtodec(octal))
    elseif choice == 6
        println("Enter the hexadecimal number")
        hex = readline()
        println("The decimal number is:",hextodec(hex))
    elseif choice == 7
        println("Goodbye!")
        break
    else
        println("Invalid choice! Please try again.")
    end
end