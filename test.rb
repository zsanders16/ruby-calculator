str = "(5 + 4) / 3 * 2 + 1"


def remove_pareth(str)
    str.sub!(/(\(.+\))/) { |inner| eval(inner.gsub!(/[()]/, "")) }

    return str
end





def eval(str)

    total = (str.count "*") + (str.count "/")

    for i in  1..total do
        str.sub!(/((\d+)\s?(\*|\/)\s?(\d+))/) { Regexp.last_match[2].to_i.send(Regexp.last_match[3], Regexp.last_match[4].to_i)}
    end

    total = (str.count "+") + (str.count "-")

    for i in  1..total do
        str.sub!(/((\d+)\s?(\+|\-)\s?(\d+))/) { Regexp.last_match[2].to_i.send(Regexp.last_match[3], Regexp.last_match[4].to_i)}
    end

    return str
end

str = remove_pareth(str)
str = eval(str)
puts str
