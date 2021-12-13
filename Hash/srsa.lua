function primeNumber(n)
    dividerFound = false
    if n == 1 or n%2 == 0 and n ~= 2 then
        dividerFound = true
    end
    currentVal = 3
    while currentVal <= math.sqrt(n) and not dividerFound do
        if n%currentVal == 0 then
            dividerFound = true
        end
        currentVal = currentVal + 2
    end
    return not dividerFound
end

function randomNumber()
    n = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9}
    number = ""
    while #number < 4 do
        cn = math.random(1, 10)
        number = number..n[cn]
    end
    return tonumber(number) + 0.0
end

function randomPrimeNumber()
    n = randomNumber()
    while primeNumber(n) == false do
        n = n - 1
    end
    return n
end

function divide(n)
    dividers = {}
    i = 1
    while i < n do
        if n%i == 0 then
            table.insert(dividers, i)
        end
        i = i + 1
    end
    return dividers
end

function primeFactor(n)
    div = divide(n)
    primeFactors = {}
    for i = 1, #div, 1 do
        if primeNumber(div[i]) then
            table.insert(primeFactors, div[i])
        end
    end
    return primeFactors
end

function factorisation(n)
    run = true
    factors = {}
    if primeNumber(n) then
        table.insert(factors, n)
        run = false
    end
    while run do
        primeFactors = primeFactor(n)
        table.insert(factors, primeFactors[1])
        n = n/primeFactors[1]
        if primeNumber(n) then
            table.insert(factors, n)
            run = false
        end
    end
    return factors
end

function srsaKeygen()
    run = true
    p = randomPrimeNumber()
    q = randomPrimeNumber()
    e = randomPrimeNumber()
    n = p*q
    m = (p-1)*(q-1)
    while factorisation(m)[e] or e > m do
        e = randomPrimeNumber()
    end
    print(e)
end

srsaKeygen()
srsaKeygen()
srsaKeygen()
srsaKeygen()
srsaKeygen()
srsaKeygen()
srsaKeygen()
srsaKeygen()
srsaKeygen()