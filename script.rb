# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity
# rubocop:disable Metrics/BlockNesting
# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/ModuleLength
module Enumerable
  def my_each
    if block_given?
      i = 0
      if instance_of?(Hash)
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
      Enumerator.new
    end
  end

  def my_each_with_index
    if block_given?
      i = 0
      if instance_of?(Hash)
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
      Enumerator.new
    end
  end

  def my_select
    i = 0
    result = []
    if block_given?
      if instance_of?(Hash)
        arr = keys
        each do |_h|
          result.push(self[arr[i]]) if yield arr[i], self[arr[i]]
          i += 1
        end
        return result
      end
      each do |f|
        filter = yield f
        result.push(f) if filter
        i += 1
      end
      result
    else
      Enumerator.new
    end
  end

  def my_all?(*args)
    result = 0
    i = 0
    if !args.empty?
      if args[0].instance_of?(Regexp)
        if instance_of?(Hash)
          each do |_h|
            result = !self[arr[i]].match(args[0]).nil?
            return false if result.nil?
            return result unless result

            i += 1
          end
          return result
        end

        each do |j|
          result = !j.match(args[0]).nil?
          return false if result.nil?
          return result unless result
        end

      elsif args[0].instance_of?(Integer) || args[0].instance_of?(Numeric)
        if instance_of?(Hash)
          each do |_h|
            result = self[arr[i]].instance_of?(Integer) || self[arr[i]].instance_of?(Numeric)
            return false if result.nil?
            return result unless result

            i += 1
          end
          return result
        end

        each do |j|
          result = j.instance_of?(Integer) || j.instance_of?(Numeric)
          return false if result.nil?
          return result unless result
        end
      else # If other type of argument
        if instance_of?(Hash)
          each do |_h|
            result = self[arr[i]].include?(args[0])
            return false if result.nil?
            return result unless result

            i += 1
          end
          return result
        end

        each do |j|
          result = j.include?(args[0])
          return false if result.nil?
          return result unless result
        end
      end
    elsif block_given? && args.length.zero?
      if instance_of?(Hash)
        each do |_h|
          result = yield arr[i], self[arr[i]]
          return false if result.nil?
          return result unless result

          i += 1
        end
        return result
      end

      each do |j|
        result = yield j
        return false if result.nil?
        return result unless result
      end
      true
    end
    result
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
#   Lastname: 'jones',
#   music: 'jazz'
# }
array = %w[tale tail talon te]
res = array.my_all?(/ta/)

puts res

def multiply_els(arr)
  arr.my_inject { |res, num| res * num }
end

# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity
# rubocop:enable Metrics/BlockNesting
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/ModuleLength
