function srsa_keygen()
    rsa_e = 0
    local primes = {2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 57, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113, 127, 131, 137, 139, 149, 151, 157, 163, 167, 173, 179, 181, 191, 193, 197, 199, 211, 223, }
  
    math.randomseed = os.time()
  
    rsa_p = primes[math.random(5,#primes)]
    rsa_q = rsa_p
  
    while rsa_q == rsa_p do
        math.randomseed = os.time()
        rsa_q = primes[math.random(5,#primes)]
    end
  
    rsa_n = rsa_p*rsa_q
    rsa_phi = (rsa_p-1)*(rsa_q-1)
  
    while rsa_e == 0 do
        local prime = primes[math.random(1,10)]
        if rsa_phi%prime > 0 then
            rsa_e = prime
        end
    end
  
    for i = 2, rsa_phi/2 do
        if ((i*rsa_phi)+1)%rsa_e == 0 then
            rsa_d = ((i*rsa_phi)+1)/rsa_e
            break
        end
    end

    pk = {rsa_n, rsa_e}
    sk = {rsa_n, rsa_d}

    return pk, sk
end

function expo(val, ex)
    c = 1
    while c < ex do
        val = val * val
        c = c + 1
    end 
    return val
end

function srsa_encrypt(pk, msg)
    encr = (msg^pk[2])%pk[1]
    return encr
end

function srsa_decrypt(sk, encr)
    decr = (encr^sk[2])%sk[1]
    return decr
end

pk = {22733.0, 11.0}
sk = {22733.0, 24467.0}

msg = 25
crypt = 18029.0
decrypt = 18029.0*25

license = "license:a91358285645d2f4a985e9a0fe1a26f90d4713f4"
user = "AirbladeHD"

local clock = os.clock
function sleep(n)-- seconds
    local t0 = clock()
    while clock() - t0 <= n do end
end

function keygen(user, license)
    timestamp = os.time()
    factor = 0
    chiffre = tostring(timestamp)..user..license
    bytes = ""
    newBytes = ""
    for i = 1, #chiffre do
        bytes = bytes..string.byte(string.sub(chiffre, i, i))
        factor = factor + tonumber(string.byte(string.sub(chiffre, i, i)))
    end
    for i = 1, #bytes do
        newBytes = newBytes..tostring(tonumber(string.sub(bytes, i, i)*factor))
    end
    bytes = newBytes
    while #bytes > 32 do
        div1 = string.sub(bytes, -2, -1)
        div2 = string.sub(bytes, -4, -3)
        if div1 > div2 then
            res = tonumber(div1) - tonumber(div2)
        else
            res = tonumber(div2) - tonumber(div1)
        end
        rep = string.reverse(div2..div1)
        bytes = string.reverse(bytes)
        bytes = string.gsub(bytes, rep, res, 1)
        bytes = string.reverse(bytes)
    end
    while #bytes < 32 do
        check = 0
        for i = 1, #bytes do
            check = check + tonumber(string.sub(bytes, i, i))
        end
        check = tostring(check)
        while #check > 1 do
            newCheck = 0
            for i = 1, #check do
                newCheck = newCheck + tonumber(string.sub(check, i, i))
            end
            check = tostring(newCheck)
        end
        bytes = bytes..check
    end
    return bytes, timestamp
end

function recreate_key(timestamp)
    user = "AirbladeHD"
    license = "license:a91358285645d2f4a985e9a0fe1a26f90d4713f4"
    factor = 0
    chiffre = tostring(timestamp)..user..license
    bytes = ""
    newBytes = ""
    for i = 1, #chiffre do
        bytes = bytes..string.byte(string.sub(chiffre, i, i))
        factor = factor + tonumber(string.byte(string.sub(chiffre, i, i)))
    end
    for i = 1, #bytes do
        newBytes = newBytes..tostring(tonumber(string.sub(bytes, i, i)*factor))
    end
    bytes = newBytes
    while #bytes > 32 do
        div1 = string.sub(bytes, -2, -1)
        div2 = string.sub(bytes, -4, -3)
        if div1 > div2 then
            res = tonumber(div1) - tonumber(div2)
        else
            res = tonumber(div2) - tonumber(div1)
        end
        rep = string.reverse(div2..div1)
        bytes = string.reverse(bytes)
        bytes = string.gsub(bytes, rep, res, 1)
        bytes = string.reverse(bytes)
    end
    while #bytes < 32 do
        check = 0
        for i = 1, #bytes do
            check = check + tonumber(string.sub(bytes, i, i))
        end
        check = tostring(check)
        while #check > 1 do
            newCheck = 0
            for i = 1, #check do
                newCheck = newCheck + tonumber(string.sub(check, i, i))
            end
            check = tostring(newCheck)
        end
        bytes = bytes..check
    end
    return bytes
end

function encode(msg, receiver)
    key, timestamp = keygen(receiver, "license:a91358285645d2f4a985e9a0fe1a26f90d4713f4")
    chars = {}
    for i = 1, #msg do
        current = string.byte(string.sub(msg, i, i))
        table.insert(chars, current)
    end
    chiff = {}
    ceil = math.ceil(math.sqrt(key))
    for i = 1, #chars do
        table.insert(chiff, chars[i]+ceil)
    end
    return chiff, timestamp
end

function decode(chiff, timestamp)
    key = recreate_key(timestamp)
    msg = ""
    ceil = math.ceil(math.sqrt(key))
    for i = 1, #chiff do
        current = chiff[i]-ceil
        if current > 255 then
            current = 255
        end
        if current < 0 then
            current = 1
        end
        msg = msg..string.char(current)
    end
    return msg
end

message = "Hello World"
enc, timestamp = encode(message, "AirbladeHD")
char = ""
for i = 1, #enc do
    char = char..enc[i].." "
end

dec = decode(enc, timestamp)

print(char..", "..timestamp)
print("")
print(dec)