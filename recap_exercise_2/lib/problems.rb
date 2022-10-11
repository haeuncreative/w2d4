# Write a method, least_common_multiple, that takes in two numbers and returns the smallest number that is a mutiple
# of both of the given numbers
require 'byebug'

def least_common_multiple(num_1, num_2)
    mul_1 = Array.new
    mul_2 = Array.new

    n = 1

    1.times do 
        mul_1 << (num_1 * n)
        mul_2 << (num_2 * n)
        common = common_element?(mul_1, mul_2)
        if common != false
            return common
        else
            n += 1
            redo
        end
    end
end

def common_element?(arr1, arr2)
    arr1.each do |num1|
        if arr2.include?(num1)
            return num1
        end
    end

    arr2.each do |num2|
        if arr1.include?(num2)
            return num2
        end
    end

    return false


end


# Write a method, most_frequent_bigram, that takes in a string and returns the two adjacent letters that appear the
# most in the string.
def most_frequent_bigram(str)
    bigrams = Hash.new(0)
    (0...str.length - 2).each do |i|
        bigrams[str[i..i + 1]] += 1
    end

    frequent = bigrams.max_by {|k, v| v}
    frequent[0]

end


class Hash
    # Write a method, Hash#inverse, that returns a new hash where the key-value pairs are swapped
    def inverse
        inverted = Hash.new
        self.each do |key, val|
            inverted[val] = key
        end
        inverted
    end
end


class Array
    # Write a method, Array#pair_sum_count, that takes in a target number returns the number of pairs of elements that sum to the given target
    def pair_sum_count(num)
        # debugger

        count = 0
        (0...self.length - 1).each do |i1|
            (i1...self.length).each do |i2|
                sum = self[i1] + self[i2]
                    if num == sum
                        count += 1 
                    end
            end
        end  
        count
    end

    # Write a method, Array#bubble_sort, that takes in an optional proc argument.
    # When given a proc, the method should sort the array according to the proc.
    # When no proc is given, the method should sort the array in increasing order.
    #
    # Sorting algorithms like bubble_sort, commonly accept a block. That block accepts
    # two parameters, which represents the two elements in the array being compared.
    # If the block returns 1, it means that the second element passed to the block
    # should go before the first (i.e. switch the elements). If the block returns -1,
    # it means the first element passed to the block should go before the second
    # (i.e. do not switch them). If the block returns 0 it implies that
    # it does not matter which element goes first (i.e. do nothing).
    #
    # This should remind you of the spaceship operator! Convenient :)

    def bubble_sort(&prc)
        # debugger
        if prc == nil
            prc = Proc.new {|a, b| a <=> b}
        end
        until sorted_by?(prc)
            (0...self.length - 1).each do |i|
                space = prc.call(self[i], self[i + 1])
                if space == 1
                    self[i], self[i + 1] = self[i + 1], self[i]
                end
            end 
        end
        self
    end

    def sorted_by?(proc)
        (0...self.length - 1).each do |i|
            space = proc.call(self[i], self[i + 1])
            if space == 1
                return false
            end
        end
        true
    end 
end
