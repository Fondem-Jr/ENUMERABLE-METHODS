# spec/enumerable_spec.rb

require 'spec_helper'
require_relative '../script'

my_array = (1..10).to_a
my_range = (1..10)
my_hash = { 'a' => 100, 'b' => 200 }

RSpec.describe Enumerable do
  context '#my_each' do
    describe 'for arrays' do
      it 'returns an emunerable when no block given' do
        expect(my_array.my_each.class).to eql(my_array.each.class)
      end
      it 'when the given an array' do
        std_result = []
        my_array.each do |j|
          std_result.push(j + j)
        end
        my_result = []
        my_array.my_each do |j|
          my_result.push(j + j)
        end
        expect(my_result).to eql(std_result)
      end
    end
    describe 'for hashes' do
      it 'when given a hash' do
        std_result = []
        my_hash.each do |_i, h|
          std_result.push(h)
        end
        my_result = []
        my_hash.my_each do |_i, h|
          my_result.push(h)
        end
        expect(my_result).to eql(std_result)
      end
    end
  end

  context '#my_each_with_index' do
    describe 'for arrays' do
      it 'returns an emunerable when no block given' do
        expect(my_array.my_each_with_index.class).to eql(my_array.each_with_index.class)
      end
      it 'when the given an array' do
        std_result = []
        my_array.each_with_index do |j, _i|
          std_result.push(j)
        end
        my_result = []
        my_array.my_each do |j, _i|
          my_result.push(j)
        end
        expect(my_result).to eql(std_result)
      end
    end

    describe 'for hashes' do
      it 'when the given a hash' do
        std_result = []
        my_hash.each_with_index do |_i, h|
          std_result.push(h)
        end
        my_result = []
        my_hash.my_each_with_index do |_i, h|
          my_result.push(h)
        end
        expect(my_result).to eql(std_result)
      end
    end
  end
  context '#my_select' do
    describe 'for no block given' do
      it 'returns an emunerable when no block given' do
        my_result = my_array.my_select.class
        std_result = my_array.select.class
        expect(my_result).to eql(std_result)
      end
    end

    describe 'for arrays' do
      it 'returns selected elements of the array' do
        my_result = my_array.my_select(&:odd?)
        std_result = my_array.select(&:odd?)
        expect(my_result).to eql(std_result)
      end
    end
    describe 'for range' do
      it 'it returns the selected element from a range' do
        my_result = my_range.my_select(&:even?)
        std_result = my_range.select(&:even?)
        expect(my_result).to eql(std_result)
      end
    end
    describe 'for symbol' do
      it 'it returns the selected element from a array of symbols' do
        my_result = %i[foo bar].my_select { |x| x == :foo }
        std_result = %i[foo bar].select { |x| x == :foo }
        expect(my_result).to eql(std_result)
      end
    end
  end

  context '#my_all' do
    describe 'for no block given' do
      it 'returns an emunerable when no block given' do
        expect(my_array.my_all?).to eql(my_array.all?)
      end
    end
    describe 'for arrays' do
      it 'returns true if all the objects in the array satisfies the given condition' do
        expect(my_array.all? { |num| num > 4 }).to eql(my_array.my_all? { |num| num > 4 })
      end
    end
    describe 'for regular expressions' do
      it 'returns true if all words in the array satisfies the regular expression' do
        expect(%w[ant bear cat].my_all?(/t/)).to eql(%w[ant bear cat].all?(/t/))
      end
    end
    describe 'for type of data' do
      it 'returns true if all objects in the array satisfies type of data' do
        std_result = [1, 2i, 3.14].my_all?(Numeric)
        my_result = [1, 2i, 3.14].all?(Numeric)
        expect(my_result).to eql(std_result)
      end
    end
    describe 'for a nil in the collection' do
      it 'returns false if nil is in the array' do
        std_result = [nil, true, 99].my_all?
        my_result = [nil, true, 99].all?
        expect(my_result).to eql(std_result)
      end
    end
  end

  context '#my_any' do
    describe 'for no block given' do
      it 'returns true if no block is given' do
        std_result = [nil, true, 99].any?
        my_result = [nil, true, 99].my_any?
        expect(my_result).to eql(std_result)
      end
    end
    describe 'for array' do
      it 'returns true if at least one of the collection member obeys the argument' do
        std_result = my_array.any? { |num| num < 5 }
        my_result = my_array.my_any? { |num| num < 5 }
        expect(my_result).to eql(std_result)
      end
    end
    describe 'for regular expression' do
      it 'returns false if none of the collection member obeys the argument' do
        std_result = %w[ant bear cat].any?(/d/)
        my_result = %w[ant bear cat].my_any?(/d/)
        expect(my_result).to eql(std_result)
      end
    end
    describe 'for nil or false member in the collection with no argument' do
      it 'return true if at least one of the collection members is not false or nil' do
        std_result = [nil, true, 99].any?
        my_result = [nil, true, 99].my_any?
        expect(my_result).to eql(std_result)
      end
    end
  end

  context '#my_none' do
    describe 'when no block is given' do
      it 'returns true when no block is given and none of the collection member is true' do
        std_result = [nil, false].none?
        my_result = [nil, false].my_none?
        expect(my_result).to eql(std_result)
      end
      it 'returns true when no block is given, using a regular expression and none of the collection member is true' do
        std_result = %w[ant bear cat].none?(/d/)
        my_result = %w[ant bear cat].my_none?(/d/)
        expect(my_result).to eql(std_result)
      end
    end
    describe 'with array and block given' do
      it 'returns true if the block never returns true for all elements in an array of numbers' do
        std_result = my_array.none? { |num| num > 20 }
        my_result = my_array.my_none? { |num| num > 20 }
        expect(my_result).to eql(std_result)
      end
      it 'returns true if the block never returns true for all elements in an array of words' do
        std_result = %w[ant bear cat].none? { |word| word.length >= 4 }
        my_result = %w[ant bear cat].my_none? { |word| word.length >= 4 }
        expect(my_result).to eql(std_result)
      end
    end
  end

  context '#my_map' do
    describe 'for no block given' do
      it 'returns an emunerable when no block given' do
        std_result = my_array.map.class
        my_result = my_array.my_map.class
        expect(my_result).to eql(std_result)
      end
    end

    describe 'for arrays' do
      it 'returns the transformed elements in a new array' do
        std_result = my_array.map { |num| num**3 }
        my_result = my_array.my_map { |num| num**3 }
        expect(my_result).to eql(std_result)
      end
    end
    describe 'for ranges' do
      it 'returns the transformed elements in a new array using range' do
        std_result = (1..4).my_map { |i| i * i }
        my_result = (1..4).map { |i| i * i }
        expect(my_result).to eql(std_result)
      end
    end
  end

  context '#my_count' do
    describe 'for no block given' do
      it 'returns an emunerable when no block given' do
        expect(my_array.count.class).to eql(my_array.my_count.class)
      end
    end
    describe 'for array' do
      it 'returns a new array with the result of running a block on an array' do
        expect(my_array.my_count.class { |i| i * i }).to eql(my_array.count.class { |i| i * i })
      end
    end
    describe 'for a range' do
      it 'returns a new array with the result of running a block on a range' do
        std_result = (1..4).count { |i| i * i }
        my_result = (1..4).my_count { |i| i * i }
        expect(my_result).to eql(std_result)
      end
    end
    describe 'for hash' do
      it 'returns a new array with the result of running a hash' do
        std_result = []
        my_hash.count do |_i, h|
          std_result.push(h)
        end
        my_result = []
        my_hash.my_count do |_i, h|
          my_result.push(h)
        end
        expect(my_result).to eql(std_result)
      end
    end
  end

  context '#my_inject' do
    describe 'Using a block and inject' do
      it 'returns the final value of memo' do
        std_result = (5..10).inject { |sum, n| sum + n }
        my_result = (5..10).my_inject { |sum, n| sum + n }
        expect(my_result).to eql(std_result)
      end
    end
    describe 'Using a block and inject' do
      it 'returns the final value of memo using a parameter' do
        std_result = (5..10).inject(1) { |product, n| product * n }
        my_result = (5..10).my_inject(1) { |product, n| product * n }
        expect(my_result).to eql(std_result)
      end
    end
    describe 'Using a block and inject to add numbers' do
      it 'returns the final value of memo using a parameter' do
        std_result = (5..10).inject(:+)
        my_result = (5..10).my_inject(:+)
        expect(my_result).to eql(std_result)
      end
    end
  end

  context '#my_multiply_els' do
    describe 'Using inject to multiply numbers' do
      it 'ruturns the multiple of the array' do
        expect(multiply_els(my_array)).to eq(3_628_800)
      end
    end
  end
end
