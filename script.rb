module Enumerable
  def my_each
    if block_given?
      i = 0
      if instance_of?(Hash.new(0).class)
        arr = keys
        each do |_h|
          yield arr[i], self[arr[i]]
          i += 1
        end
        return self
      end
      each do |j|
        yield j
        i += 1
      end
      self
    else
      []
    end
  end

  def my_each_with_index
    if block_given?
      i = 0
      if instance_of?(Hash.new(0).class)
        arr = keys
        each do |_h|
          yield arr[i], self[arr[i]], i
          i += 1
        end
        return self
      end
      each do |j|
        yield j, i
        i += 1
      end
      self
    else
      []
    end
  end

  def my_select
    i = 0
    result = []
    while i < length
      filter = yield self[i]
      result.push(self[i]) if filter
      i += 1
    end
    result
  end

  def my_all?
    i = 0
    while i < length
      result = yield self[i]
      return result unless result

      i += 1
    end
    true
  end

  def my_any?
    i = 0
    while i < length
      result = yield self[i]
      return result if result

      i += 1
    end
    false
  end

  def my_none?
    i = 0
    while i < length
      result = yield self[i]
      return false if result

      i += 1
    end
    true
  end

  def my_map(*args)
    if block_given?
      result = []
      if args.length == 1
        each do |i|
          result.push(args[0].call(i))
        end
      else
        each do |i|
          result.push(yield i)
        end
      end
      result
    else
    []
    end
  end

  def my_count(*args)
    j = 0
    if !block_given?
      j = no_block(self, args)
    elsif block_given? && args.empty?
      each do |k|
        j += 1 if yield k
      end
    end
    j
  end

  def my_inject(*args)
    i = if args.length == 1
          yield args[0], self[0]
        else
          self[0]
        end
    j = 1
    while j <= length - 1
      i = yield i, self[j]
      j += 1
    end
    i
  end
end

def no_block(arr, rule)
  if rule.empty?
    no_args_no_block(arr)
  else
    args_no_blocks(arr, rule)
  end
end

# Auxiliaries for my_count (due to complexity flags by Rubocop)
def no_args_no_block(arr)
  j = 0
  puts arr
  arr.each do
    j += 1
  end
  j
end

def args_no_blocks(arr, rule)
  j = 0
  arr.each do |h|
    j += 1 if h == rule[0]
  end
  j
end

# hash = {
#   name: 'john',
#   Lastname: 'sena'
# }
# res = hash.my_each_with_index { |key, value, index| puts "#{key} #{value}  #{index}" }


array = ["hi", "hey"]

 puts array.my_map
