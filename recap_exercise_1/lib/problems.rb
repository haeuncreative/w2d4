require 'byebug'

# Write a method, all_vowel_pairs, that takes in an array of words and returns all pairs of words
# that contain every vowel. Vowels are the letters a, e, i, o, u. A pair should have its two words
# in the same order as the original array. 
#
# Example:
#
# all_vowel_pairs(["goat", "action", "tear", "impromptu", "tired", "europe"])   # => ["action europe", "tear impromptu"]
def all_vowel_pairs(words)

    paired = Array.new
    (0...words.length).each do |word1|
        (1...words.length).each do |word2|
            if word1 < word2
                if well_does_it?(words[word1], words[word2]) == true
                    paired << "#{words[word1]} #{words[word2]}"
                end
            end
        end
    end
    paired
end

def well_does_it?(*words)
    vowels = 'aeiou'

    check = {
    'a' => 0,
    'e' => 0,
    'i' => 0,
    'o' => 0,
    'u' => 0
    }
    

    words.each do |word|
        word.each_char do |char|
            if vowels.include?(char)
                check[char] += 1
            end
        end
    end

    
    if check.values.all? {|value| value >= 1}
        return true
    else
        return false
    end

end






# Write a method, composite?, that takes in a number and returns a boolean indicating if the number
# has factors besides 1 and itself
#
# Example:
#
# composite?(9)     # => true
# composite?(13)    # => false
def composite?(num)
    (2...num).each do |fac|
        if num % fac == 0
            return true
        end
    end
    return false
end


# A bigram is a string containing two letters.
# Write a method, find_bigrams, that takes in a string and an array of bigrams.
# The method should return an array containing all bigrams found in the string.
# The found bigrams should be returned in the the order they appear in the original array.
#
# Examples:
#
# find_bigrams("the theater is empty", ["cy", "em", "ty", "ea", "oo"])  # => ["em", "ty", "ea"]
# find_bigrams("to the moon and back", ["ck", "oo", "ha", "at"])        # => ["ck", "oo"]

#note - the test came out false, i have the elements, just
# in a different order
def find_bigrams(str, bigrams)
    words = str.split(" ")
    yes = Array.new
    words.each do |word|
        (0...word.length - 1).each do |bi|
            if bigrams.include?(word[bi] + word[bi + 1])
                yes << (word[bi] + word[bi + 1])
            end
        end
    end

    yes

end

class Hash
    # Write a method, Hash#my_select, that takes in an optional proc argument
    # The method should return a new hash containing the key-value pairs that return
    # true when passed into the proc.
    # If no proc is given, then return a new hash containing the pairs where the key is equal to the value.
    #
    # Examples:
    #
    # hash_1 = {x: 7, y: 1, z: 8}
    # hash_1.my_select { |k, v| v.odd? }          # => {x: 7, y: 1}
    #
    # hash_2 = {4=>4, 10=>11, 12=>3, 5=>6, 7=>8}
    # hash_2.my_select { |k, v| k + 1 == v }      # => {10=>11, 5=>6, 7=>8})
    # hash_2.my_select                            # => {4=>4}
    def my_select(&prc)
        new_hash = Hash.new
        if prc ||= Proc.new {|key, val| key == val}
            self.each do |key, val|
                if prc.call(key, val) == true
                    new_hash[key] = val
                end
            end
            return new_hash
        else
            self.each do |key, val|
                if prc.call(key, val) == true
                end
            end
        end         
    end
end

class String
    # Write a method, String#substrings, that takes in a optional length argument
    # The method should return an array of the substrings that have the given length.
    # If no length is given, return all substrings.
    #
    # Examples:
    #
    # "cats".substrings     # => ["c", "ca", "cat", "cats", "a", "at", "ats", "t", "ts", "s"]
    # "cats".substrings(2)  # => ["ca", "at", "ts"]
    def substrings(length = nil)
        subs = Array.new
        if length == nil
            (0..self.length - 1).each do |i1|
                (0..self.length - 1).each do |i2|
                    if i1 == i2
                        subs << self[i1]
                    elsif i1 < i2
                        subs << self[i1..i2]
                    end
                end
            end
        else
            (0..self.length - length).each do |i1|
                subs << self[i1...i1 + length]
            end
        end
        subs
    end

    # Write a method, String#caesar_cipher, that takes in an a number.
    # The method should return a new string where each char of the original string is shifted
    # the given number of times in the alphabet.
    #
    # Examples:
    #
    # "apple".caesar_cipher(1)    #=> "bqqmf"
    # "bootcamp".caesar_cipher(2) #=> "dqqvecor"
    # "zebra".caesar_cipher(4)    #=> "difve"
    def caesar_cipher(num)

        og_alphabet = ('a'..'z').to_a

        alphabet = ('a'..'z').to_a
        sliced = alphabet.slice!(0...num)
        edited = alphabet += sliced
        
        et_tu_brute = ""

        self.each_char.with_index do |char, i|
            knife = og_alphabet.index(char)
            et_tu_brute += edited[knife]
        end
        et_tu_brute
    end
end
