import lupa
from lupa import LuaRuntime
lua = LuaRuntime(unpack_returned_tuples=True)
preCompose = lua.eval('''
    function(text)
        raw = ""
        bytes = ""
        factor = 1
        byteLen = 1024

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
            sub = tostring(string.format('%.0f',sub))
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
''')

blockify = lua.eval('''
    function(text)
        blocks = {}
        index = 1
        for i = 1, 33, 1 do
            block = string.sub(text, index, index + 32)
            index = index + 32
            table.insert(blocks, tonumber(block))
        end
        return blocks
    end
''')

toBinary = lua.eval('''
    function(number)
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
''')

binarySwitcher = lua.eval('''
    function(blocks)
        for i = 1, #blocks, 1 do
            block = blocks[i]

            bin = ""
            while block ~= 1 do
                if math.fmod(block,2) ~= 0 then
                    block = block - 1
                    block = block / 2
                    bin = bin.."1"
                else
                    block = block / 2
                    bin = bin.."0"
                end
            end
            bin = bin.."1"
            bin = string.reverse(bin)
            block = bin
            while #block < 64 do
                block = block.."0"
            end
            while #block > 64 do
                block = string.reverse(block)
                block = string.gsub(block, "0", "", 1)
                block = string.reverse(block)
            end
            blocks[i] = block
        end
        return blocks
    end
''')

shifter = lua.eval('''
    function(bin, amo)
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
''')

shuffle = lua.eval('''
    function(blocks)
        newBlocks = {}
        oldBlocks = {}
        factors = {8, 9, 1, 0, 8, 1, 0, 1, 1, 1, 0, 1, 0, 5, 9, 7, 7, 9, 5, 0, 1, 0, 1, 1, 1, 0, 1, 8, 0, 1, 9, 8}
        for i = 1, #blocks, 1 do
            if math.fmod(i, 2) == 0 then
                factor = factors[i]
                shifted = blocks[i]

                chars = {}
                newBin = ""
                counter = 0
                for i = 1, #shifted, 1 do
                    table.insert(chars, string.sub(shifted, i, i))
                end
                while counter ~= factor do
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

                shifted = newBin

                table.insert(newBlocks, shifted)
            else
                table.insert(oldBlocks, blocks[i])
            end
        end

        return newBlocks, oldBlocks
    end
''')

XOR = lua.eval('''
    function(bin1, bin2)
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
''')

lXOR = lua.eval('''
    function(list1, list2)
        newBins = {}
        for i = 1, #list1, 1 do

            bin1 = list1[i]
            bin2 = list2[i]
            newBin = ""
            for c = 1, #bin1, 1 do
                if string.sub(bin1, c, c) == "1" and string.sub(bin2, c, c) == "1" then
                    newBin = newBin.."0"
                else
                    if string.sub(bin1, c, c) == "1" or string.sub(bin2, c, c) == "1" then
                        newBin = newBin.."1"
                    else
                        newBin = newBin.."0"
                    end
                end
            end
            table.insert(newBins, newBin)

        end
        return newBins
    end
''')

binarySwitcherReverse = lua.eval('''
    function(bin)
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
''')

toDecimal = lua.eval('''
    function(list)
        decimals = {}
        for i = 1, #list, 1 do

            bin = list[i]
            c = 1
            for i = 1, #bin, 1 do
                if i ~= 1 then
                    c = c * 2
                    if string.sub(bin, i, i) == "1" then
                        c = c + 1
                    end
                end
            end
            bin = math.abs(tonumber(c))

            table.insert(decimals, bin)
        end
        return decimals
    end
''')

toHex = lua.eval('''
    function(val)
        hex = string.format('%x', val)
        return hex
    end
''')

processor = lua.eval('''
    function(list)
        processed = ""
        for i = 1, #list, 1 do
            list[i] = math.ceil(math.sqrt(math.sqrt(list[i])*16))
            if list[i] < 100000 then
                list[i] = list[i] + 891081
            end

            val = list[i]
            hex = string.format('%x', val)

            processed = processed..hex
        end
        return processed
    end
''')

preHash = lua.eval('''
    function(string)
        composed = preCompose(string)
        blocks = blockify(composed)
        binaryBlocks = binarySwitcher(blocks)
        switched = shuffle(binaryBlocks)
        logicalXOR = lXOR(binaryBlocks, switched)
        decimal = toDecimal(logicalXOR)
        process = processor(decimal)

        return process
    end
''')

def dukeHash(string):
    #preHashed = preCompose(string)
    #blocks = blockify(preHashed)
    #binaryBlocks = binarySwitcher(blocks)
    #switched = shuffle(binaryBlocks)
    #logicalXOR = lXOR(binaryBlocks, switched)
    #decimal = toDecimal(logicalXOR)
    #process = processor(decimal)
    composed = preCompose(string)
    blocks = blockify(composed)
    binaryBlocks = binarySwitcher(blocks)
    switched, nonSwitched = shuffle(binaryBlocks)
    logicalXOR = lXOR(nonSwitched, switched)
    decimal = toDecimal(logicalXOR)
    hex = "duke$" + str(processor(decimal))

    return hex