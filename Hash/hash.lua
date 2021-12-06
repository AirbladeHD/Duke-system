function preCompose(text)

    raw = ""
    bytes = ""
    factor = 1
    byteLen = 256

    for i = 1, #text, 1 do
        raw = raw..string.byte(text, i)
        factor = factor + tonumber(string.byte(text, i))
    end

    while #bytes < byteLen do
        for i = 1, #raw, 1 do
            bytes = bytes..tostring(tonumber(string.sub(raw, i, i))*factor)
            factor = factor + tonumber(string.sub(raw, i, i))
        end
    end

    while #bytes > byteLen do
        sub1 = string.sub(bytes, -16, -1)
        sub2 = string.sub(bytes, -32, -17)
        if tonumber(sub1) > tonumber(sub2) then
            sub = tonumber(sub1) - tonumber(sub2)
        else
            sub = tonumber(sub2) - tonumber(sub1)
        end
        sub = tostring(string.format("%.0f",sub))
        bytes = string.gsub(bytes, sub2..sub1, sub, 1)
    end

    while #bytes < byteLen do
        sub1 = tonumber(string.sub(bytes, -1))
        sub2 = tonumber(string.sub(bytes, -2, -2))
        if sub1 > sub2 then
            sub = sub1 - sub2
        else
            sub = sub2 - sub1
        end
        bytes = bytes..tostring(sub)
    end

    while #bytes < byteLen do
        sub1 = tonumber(string.sub(bytes, -1))
        sub2 = tonumber(string.sub(bytes, -2, -2))
        if sub1 > sub2 then
            sub = sub1 - sub2
        else
            sub = sub2 - sub1
        end
        rep = tostring(sub2)..tostring(sub1)
        bytes = string.gsub(bytes, rep, tostring(sub), 1)
    end

    return bytes

end

function blockify(text)
    blockCount = #text / 16
    blocks = {}
    index = 1
    for i = 1, blockCount, 1 do
        block = string.sub(text, i, i + 16)
        index = index + 16
        table.insert(blocks, block)
    end

    return blocks

end

function toBinary(number)
    bin = ""
    while number ~= 1 do
        if math.fmod(number,2) ~= 0 then
            number = number - 1
            number = number / 2
            bin = bin.."1"
        else
            number = number / 2
            bin = bin.."0"
        end
    end
    bin = bin.."1"
    bin = string.reverse(bin)
    return bin
end

function binarySwitcher(blocks)
    for i = 1, #blocks, 1 do
        block = toBinary(blocks[i])
        while #block < 64 do
            block = block.."0"
        end
        blocks[i] = block
    end
    return blocks
end

function shifter(bin, amo)
    chars = {}
    newBin = ""
    counter = 0
    for i = 1, #bin, 1 do
        table.insert(chars, string.sub(bin, i, i))
    end
    while counter ~= amo do
        for i = 1, #chars, 1 do
            c = i + 1
            if c > #chars then
                c = 1
            end
            chars[i] = chars[c]
        end
        counter = counter + 1
    end

    for i = 1, #chars, 1 do
        newBin = newBin..chars[i]
    end

    return newBin
end

function shuffle(blocks)
    newBlocks = {}
    factors = {8, 9, 1, 0, 8, 1, 0, 1, 1, 1, 0, 1, 0, 5, 9, 7}
    for i = 1, #blocks, 1 do
        factor = factors[i]
        shifted = shifter(blocks[i], factor)
        table.insert(newBlocks, shifted)
    end
    return newBlocks
end

function XOR(bin1, bin2)
    newBin = ""
    for i = 1, #bin1, 1 do
        if string.sub(bin1, i, i) == "1" then
            newBin = newBin.."1"
        else
            if string.sub(bin2, i, i) == "1" then
                newBin = newBin.."1"
            else
                newBin = newBin.."0"
            end
        end
    end
    return newBin
end

function lXOR(list1, list2)
    newBins = {}
    for i = 1, #list1, 1 do
        table.insert(newBins, XOR(list1[i], list2[i]))
    end
    return newBins
end

function binarySwitcherReverse(bin)
    c = 1
    for i = 1, #bin, 1 do
        if i ~= 1 then
            c = c * 2
            if string.sub(bin, i, i) == "1" then
                c = c + 1
            end
        end
    end
    return math.abs(tonumber(c))
end

function toDecimal(list)
    decimals = {}
    for i = 1, #list, 1 do
        table.insert(decimals, binarySwitcherReverse(list[i]))
    end
    return decimals
end

function toHex(val)
    hex = string.format("%x", val)
    return hex
end

function processor(list)
    processed = ""
    for i = 1, #list, 1 do
        list[i] = math.ceil(math.sqrt(math.sqrt(list[i])*16))
        if list[i] < 100000 then
            list[i] = list[i] + 891081
        end
        processed = processed..toHex(list[i])
    end
    return processed
end

function preHash(string)
    composed = preCompose(string)
    blocks = blockify(composed)
    binaryBlocks = binarySwitcher(blocks)
    switched = shuffle(binaryBlocks)
    logicalXOR = lXOR(binaryBlocks, switched)
    decimal = toDecimal(logicalXOR)
    process = processor(decimal)

    return process
end

function hash(string)
    preHashed = preHash(string)
    composed = preCompose(preHashed)
    blocks = blockify(composed)
    binaryBlocks = binarySwitcher(blocks)
    switched = shuffle(binaryBlocks)
    logicalXOR = lXOR(binaryBlocks, switched)
    decimal = toDecimal(logicalXOR)
    hex = "duke$"..processor(decimal)

    return hex
end

print(hash("Hello World"))