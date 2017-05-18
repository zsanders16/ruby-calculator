@left_hand
@right_hand
@operator

def main
    puts "Welcome to a ridiculous calulator app \n\n"

    puts "What would you like to do?"
    puts "1) Enter indiviual numbers"
    puts "2) Enter mathmatical phrase"
    puts "3) Quit"

    answer = gets.chomp

    case answer
        when "1"
            get_lh_input
            get_operator_input
            get_rh_input

            calculate  

            menu 
        when "2"
            eval_math_phrase
        when "3"
            puts "Goodbye"
        else
            put "Iinvalid input, try again"
            main
    end
end

def menu
    puts "Please select an option"
    puts "1) Continue with this operation"
    puts "2) Start a new operation"
    puts "3) Return to main menu"
    puts "4) Quit"

    input = gets.chomp

    case input
        when "1"

            get_operator_input
            get_rh_input

            calculate
            menu
        when "2"
            get_lh_input
            get_operator_input
            get_rh_input

            calculate
            menu
        when "3"
            main
        when "4"
            puts "Goodbye"
        else 
            puts "Invalid input, try again"
            menu
    end
end


def validate_number(num)
    !!(num =~ /^\d+$/)
end

def validate_operator(operator)
    !!(operator =~ /^[+*\/-]{1}$/)
end

def get_num_input
    puts "Enter your number"
end

def get_lh_input
    
    puts "Input your first number."
    lh = gets.chomp
    if validate_number(lh)
        @left_hand = lh.to_i
        lh_valid = true   
    else
        puts "You are stupid, that is not a valid, try again"
    end
end

def get_operator_input
    
    puts "Input which operator you want to do ( *, /, +, -)"
    operator = gets.chomp
    if validate_operator(operator)
        @operator = operator
        operator_valid = true
    else
        puts "Invalid input, try again"
    end
end

def get_rh_input

    puts "Input your second number."
    rh = gets.chomp
    if validate_number(rh)
        @right_hand = rh.to_i
        rh_valid = true   
    else
        puts "You are stupid, that is not a valid, try again"
    end
end

def calculate

    answer = @left_hand.send(@operator, @right_hand)
    puts "Your answer is #{answer} \n\n"
    @left_hand = answer
end  

def eval_math_phrase
    puts "Input a mathmatical pharse like 7+6+(2*3)"
    phrase = gets.chomp

    phrase = parentheses(phrase)
    phrase = order_of_operations(phrase)

    puts "The answer is #{phrase}"    

    menu
end

def parentheses(str) 
    str.sub!(/(\(.+\))/) { |inner| order_of_operations(inner.gsub!(/[()]/, "")) }

    return str
end

def order_of_operations(str)

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

main

