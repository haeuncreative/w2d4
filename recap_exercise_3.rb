require 'byebug'
# General Problems
# no_dupes?
# Write a method no_dupes?(arr) that accepts an array as an arg and 
# returns an new array containing the elements that were not repeated in the array.

def no_dupes?(arr)
    dup_hash = Hash.new(0)
    arr.each {|ele| dup_hash[ele] += 1}
    dup_hash.delete_if{|key, val| val != 1}
    dup_hash.keys
end

# # Examples
p 'no_dupes'
p no_dupes?([1, 1, 2, 1, 3, 2, 4])         # => [3, 4]
p no_dupes?(['x', 'x', 'y', 'z', 'z'])     # => ['y']
p no_dupes?([true, true, true])            # => []
p '_________________________'

# no_consecutive_repeats?
# Write a method no_consecutive_repeats?(arr) that accepts an array 
# as an arg. The method should return true if an element never 
# appears consecutively in the array; it should return false otherwise.
def no_consecutive_repeats?(arr)
    arr.each_with_index do |ele, i|
        if arr[i] == arr[i + 1]
            return false
        end
    end
    return true
end
# # Examples
p 'no consecutive repeats'
p no_consecutive_repeats?(['cat', 'dog', 'mouse', 'dog'])     # => true
p no_consecutive_repeats?(['cat', 'dog', 'dog', 'mouse'])     # => false
p no_consecutive_repeats?([10, 42, 3, 7, 10, 3])              # => true
p no_consecutive_repeats?([10, 42, 3, 3, 10, 3])              # => false
p no_consecutive_repeats?(['x'])                              # => true
p '_________________________'

# char_indices
# Write a method char_indices(str) that takes in a string as 
# an arg. The method should return a hash containing characters 
# as keys. The value associated with each key should be an array 
# containing the indices where that character is found.

def char_indices(string)
    index_hash = Hash.new {|h, k| h[k] = Array.new}
    string.each_char.with_index do |char, i|
        index_hash[char] << i
    end
    index_hash
end

# # Examples
p 'char indices'
p char_indices('mississippi')   # => {"m"=>[0], "i"=>[1, 4, 7, 10], "s"=>[2, 3, 5, 6], "p"=>[8, 9]}
p char_indices('classroom')     # => {"c"=>[0], "l"=>[1], "a"=>[2], "s"=>[3, 4], "r"=>[5], "o"=>[6, 7], "m"=>[8]}
p '_________________________'

# longest_streak
# Write a method longest_streak(str) that accepts a string as an 
# arg. The method should return the longest streak of consecutive 
# characters in the string. If there are any ties, return the streak 
# that occurs later in the string.

def longest_streak(string)
    
    longest = ""
    streak_hash = Hash.new(0)
    count = 0
    chars = string.split("")
    chars.each do |char|
        streak_hash[char] += 1
    end

    max = streak_hash.max_by(2) {|key, val| val}
    max.flatten!
    if max.any? {|ele| ele.instance_of?(Array)}
        max_keys = Array.new
        max.each do |sub|
            max_keys << sub[0]
        end
        if string.index(max_keys[0]) >= string.index(max_keys[1])
            streak_hash[max_keys[0]].times {longest += max_keys[0]}
            longest
        elsif string.index(max_keys[0]) <= string.index(max_keys[1])
            streak_hash[max_keys[1]].times {longest += max_keys[1]}
            longest
        end
    else
        max[1].times {longest += max[0]}
        longest
    end
end

# # Examples
p 'longest streak'
p longest_streak('a')           # => 'a'
p longest_streak('accccbbb')    # => 'cccc'
p longest_streak('aaaxyyyyyzz') # => 'yyyyy
p longest_streak('aaabbb')      # => 'bbb'
p longest_streak('abc')         # => 'c'
p '_________________________'

# bi_prime?
# Write a method bi_prime?(num) that accepts a number as an arg and 
# returns a boolean indicating whether or not the number is a bi-prime. 
# A bi-prime is a positive integer that can be obtained by 
# multiplying two prime numbers.

# For Example:

def bi_prime?(num)
    factors = factors(num)
    primes = factors.select {|factor| prime?(factor)}

    if primes.length == 1
        if primes[0] ** 2 == num
            return true
        end
    end


    (0...primes.length - 1).each do |i1|
        (1..primes.length - 1).each do |i2|
            if i2 > i1
                if primes[i1] * primes[i2] == num
                    return true
                end
            end
        end
    end
    return false
end

def factors(num)
    factors = Array.new
    (2...num).each do |fac|
        if num % fac == 0
            factors << fac
        end
    end
    factors
end

def prime?(num)
    if num == 2
        return true
    else
        (2...num).each do |fac|
            if num % fac == 0
                return false
            end
        end
    end

    return true

end
# 14 is a bi-prime because 2 * 7
# 22 is a bi-prime because 2 * 11
# 25 is a bi-prime because 5 * 5
# 24 is not a bi-prime because no two prime numbers have a product of 24
# # Examples
p 'bi prime'
p bi_prime?(14)   # => true
p bi_prime?(22)   # => true
p bi_prime?(25)   # => true
p bi_prime?(94)   # => true
p bi_prime?(24)   # => false
p bi_prime?(64)   # => false
p '_________________________'

# vigenere_cipher
# A Caesar cipher takes a word and encrypts it by offsetting each 
# letter in the word by a fixed number, called the key. Given 
# a key of 3, for example: a -> d, p -> s, and y -> b.

# A Vigenere Cipher is a Caesar cipher, but instead of a single key, 
# a sequence of keys is used. For example, if we encrypt 
# "bananasinpajamas" with the key sequence [1, 2, 3], 
# then the result would be "ccqbpdtkqqcmbodt":

# # Message:  b a n a n a s i n p a j a m a s
# # Keys:     1 2 3 1 2 3 1 2 3 1 2 3 1 2 3 1
# # Result:   c c q b p d t k q q c m b o d t
# Write a method vigenere_cipher(message, keys) that accepts a 
# string and a key-sequence as args, returning the encrypted 
# message. Assume that the message consists of only lowercase 
# alphabetic characters.

def vigenere_cipher(message, keys)
    vigenere = Array.new
    n = 0
    m = 0
    while n < message.length
        vigenere << caesar_cipher(message[n], keys[m])
        n += 1
        m += 1
        if m > keys.length - 1
            m = 0
        end
    end
    vigenere.join("")
end

def caesar_cipher(char, num)
    og_alphabet = ('a'..'z').to_a

    alphabet = ('a'..'z').to_a
    sliced = alphabet.slice!(0...num)
    edited = alphabet += sliced
        
    et_tu_brute = ""

    
    knife = og_alphabet.index(char)
    et_tu_brute += edited[knife]
    et_tu_brute
end

# # Examples
p 'vigenere cipher'
p vigenere_cipher("toerrishuman", [1])        # => "upfssjtivnbo"
p vigenere_cipher("toerrishuman", [1, 2])     # => "uqftsktjvobp"
p vigenere_cipher("toerrishuman", [1, 2, 3])  # => "uqhstltjxncq"
p vigenere_cipher("zebra", [3, 0])            # => "ceerd"
p vigenere_cipher("yawn", [5, 1])             # => "dbbo"
p '_________________________'

# vowel_rotate
# Write a method vowel_rotate(str) that accepts a string as an arg 
# and returns the string where every vowel is replaced with the 
# vowel that appears before it sequentially in the original string. 
# The first vowel of the string should be replaced with the last vowel.

def vowel_rotate(string)
    chars = string.split("")
    vowels = Array.new
    cons = Array.new
    vowel_flag = Hash.new

    chars.each_with_index do |char, i|
        if is_vowel?(char)
            vowel_flag[i] = true
            vowels << char
        else
            vowel_flag[i] = false
            cons << char
        end
    end

    shifted = vowels.pop
    vowels.unshift(shifted)

    word_shifted = Array.new
    vowel_flag.each_pair do |key, flag|
        if flag == true
            word_shifted << vowels.shift
        else
            word_shifted << cons.shift
        end
    end

    word_shifted.join("")

end

def is_vowel?(char)
    vowels = 'aeiou'
    if vowels.include?(char)
        return true
    else
        return false
    end
end

# # Examples
p 'vowel_rotate'
p vowel_rotate('computer')      # => "cempotur"
p vowel_rotate('oranges')       # => "erongas"
p vowel_rotate('headphones')    # => "heedphanos"
p vowel_rotate('bootcamp')      # => "baotcomp"
p vowel_rotate('awesome')       # => "ewasemo"
p '_________________________'

# Proc Problems
class String

    def select(&proc)
        selected = ""
        if proc == nil
            return ""
        else
            self.each_char do |char|
                if proc.call(char)
                    selected += char
                end
            end
            return selected
        end
    end

#     # String#select
#     # Extend the string class by defining a String#select method 
#     # that accepts a block. The method should return a new string 
#     # containing characters of the original string that return true 
#     # when passed into the block. If no block is passed, then return 
#     # the empty string. Do not use the built-in Array#select in your 
#     # solution.
#     def select(&proc)


#     end
end
# # # Examples
p 'String Select'
p "app academy".select { |ch| !"aeiou".include?(ch) }   # => "pp cdmy"
p "HELLOworld".select { |ch| ch == ch.upcase }          # => "HELLO"
p "HELLOworld".select          # => ""
p '_________________________'

# # String#map!
# # Extend the string class by defining a String#map! method that 
# # accepts a block. The method should modify the existing string 
# # by replacing every character with the result of calling the 
# # block, passing in the original character and it's index. Do not 
# # use the built-in Array#map or Array#map! in your solution.
class String

    def map!(&proc)
        self.each_char.with_index do |char, i|
            self[i] = proc.call(char, i)
        end
    end

end
    # # Examples
    p 'string map'
    word_1 = "Lovelace"
    word_1.map! do |ch| 
        if ch == 'e'
            '3'
        elsif ch == 'a'
            '4'
        else
            ch
        end
    end
    p word_1        # => "Lov3l4c3"

    word_2 = "Dijkstra"
    word_2.map! do |ch, i|
        if i.even?
            ch.upcase
        else
            ch.downcase
        end
    end
    p word_2        # => "DiJkStRa"
p '_________________________'



# # Recursion Problems
# # multiply
# # Write a method multiply(a, b) that takes in two numbers 
# # and returns their product.

def multiply(a, b)

    if a < 0 && b < 0
        a = a.abs
        b = b.abs
    elsif a > 0 && b < 0
        a = 0 - a
    end

    return 0 if b == 0
    a + multiply(a, b.abs - 1)

end

# # You must solve this recursively (no loops!)
# # You must not use the multiplication (*) operator
# # # Examples
p 'multiply but spicy'
p multiply(3, 5)        # => 15
p multiply(5, 3)        # => 15
p multiply(2, 4)        # => 8
p multiply(0, 10)       # => 0
p multiply(-3, -6)      # => 18
p multiply(3, -6)       # => -18
p multiply(-3, 6)       # => -18
p '_________________________'

# # lucas_sequence
# # The Lucas Sequence is a sequence of numbers. The first number of 
# # the sequence is 2. The second number of the Lucas Sequence is 1. 
# # To generate the next number of the sequence, we add up the previous 
# # two numbers. For example, the first six numbers of the sequence 
# # are: 2, 1, 3, 4, 7, 11, ...

# # Write a method lucasSequence that accepts a number representing a 
# # length as an arg. The method should return an array containing the 
# # Lucas Sequence up to the given length. Solve this recursively.

def lucas_sequence(l)
    if l == 0
        return []
    elsif l == 1
        return [2]
    elsif l == 2
        return [2, 1]
    end

    lucas_sequence = lucas_sequence(l - 1)
    lucas_sequence << lucas_sequence[-1] + lucas_sequence[-2]
    lucas_sequence
end

# # Examples
p 'lucas sequence'
p lucas_sequence(0)   # => []
p lucas_sequence(1)   # => [2]    
p lucas_sequence(2)   # => [2, 1]
p lucas_sequence(3)   # => [2, 1, 3]
p lucas_sequence(6)   # => [2, 1, 3, 4, 7, 11]
p lucas_sequence(8)   # => [2, 1, 3, 4, 7, 11, 18, 29]
p '_________________________'

# # p prime_factorization
# # The Fundamental Theorem of Arithmetic states that every positive 
# # integer is either a prime or can be represented as a product of 
# # prime numbers.

# # Write a method p prime_factorization(num) that accepts a number and 
# # returns an array representing the prime factorization of the given 
# # number. This means that the array should contain only prime numbers 
# # that multiply together to the given num. The array returned should 
# # contain numbers in ascending order. Do this recursively.

def prime_factorization(num)
    if num == 1 
        return []
    end
    (2...num).each do |factor|
        if num % factor == 0
            larger_factor = num / factor
            return [ *prime_factorization(fact), *prime_factorization(larger_factor)]
        end
    end
    [num]
end

def prime_factorization(num)
    (2...num).each do |fact|
        if (num % fact == 0)
            otherFact = num / fact
            return [ *prime_factorization(fact), *prime_factorization(otherFact) ]
        end
    end

    [num]

end


# # Examples
p 'prime factorization'
p prime_factorization(12)     # => [2, 2, 3]
p prime_factorization(24)     # => [2, 2, 2, 3]
p prime_factorization(25)     # => [5, 5]
p prime_factorization(60)     # => [2, 2, 3, 5]
p prime_factorization(7)      # => [7]
p prime_factorization(11)     # => [11]
p prime_factorization(2017)   # => [2017]