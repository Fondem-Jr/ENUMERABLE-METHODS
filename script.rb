# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity
# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/ModuleLength
# rubocop:disable Style/DoubleNegation
module Enumerable
  def my_each
    return to_enum unless block_given?

    i = 0
    if instance_of?(Hash)
      each do |h|
        yield h
        i += 1
      end
      return self
    end
    each do |j|
      yield j
      i += 1
    end
  end

  def my_each_with_index
    return to_enum unless block_given?

    i = 0
    if instance_of?(Hash)
      each do |h|
        yield h, i
        i += 1
      end
      return self
    end
    each do |j|
      yield j, i
      i += 1
    end
  end

  def my_select
    i = 0
    result = []
    if block_given?
      if instance_of?(Hash)
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
      to_enum
    end
  end

  def my_all?(*args)
    result = 0
    keyhold = 1
    valuehold = 1

    noin_lambda = ->(x) { !!x }

    if instance_of?(Hash)
      keyhold = keys
      valuehold = values
    end

    if block_given?
      each do |i|
        result = instance_of?(Hash) ? (yield keyhold[indexOf(i)], valuehold[indexOf(i)]) : (yield i)
        return result unless result
      end
    elsif !block_given? && args.empty?
      each do |i|
        result = instance_of?(Hash) ? noin_lambda.call(valuehold[indexOf(i)]) : noin_lambda.call(i)
        return result unless result
      end
    elsif args[0].instance_of?(Regexp)
      each do |i|
        result = instance_of?(Hash) ? !!valuehold[indexOf(i)].match(args[0]) : !!i.match(args[0])
        return result unless result
      end
    elsif args[0].instance_of?(Class)
      each do |i|
        result = instance_of?(Hash) ? !!valuehold[indexOf(i)].instance_of?(args[0]) : !!i.instance_of?(args[0])
        return result unless result
      end
    else
      each do |i|
        result = instance_of?(Hash) ? (valuehold[indexOf(i)] == args[0]) : (i == args[0])
        return result unless result
      end
    end
    result
  end

  def my_any?(*args)
    result = 0
    keyhold = 1
    valuehold = 1

    noin_lambda = ->(x) { !!x }
    if instance_of?(Hash)
      keyhold = keys
      valuehold = values
    end

    if block_given?
      each do |i|
        result = instance_of?(Hash) ? (yield keyhold[indexOf(i)], valuehold[indexOf(i)]) : (yield i)
        return result if result
      end
    elsif !block_given? && args.empty?
      each do |i|
        result = instance_of?(Hash) ? noin_lambda.call(valuehold[indexOf(i)]) : noin_lambda.call(i)
        return result if result
      end
    elsif args[0].instance_of?(Regexp)
      each do |i|
        result = instance_of?(Hash) ? !!valuehold[indexOf(i)].match(args[0]) : !!i.match(args[0])
        return result if result
      end
    elsif args[0].instance_of?(Class)
      each do |i|
        result = instance_of?(Hash) ? !!valuehold[indexOf(i)].instance_of?(args[0]) : !!i.instance_of?(args[0])
        return result if result
      end
    else
      each do |i|
        result = instance_of?(Hash) ? (valuehold[indexOf(i)] == args[0]) : (i == args[0])
        return result if result
      end
    end
    result
  end

  def my_none?(*args)
    result = 0
    keyhold = 1
    valuehold = 1

    noin_lambda = ->(x) { !!x }
    if instance_of?(Hash)
      keyhold = keys
      valuehold = values
    end

    if block_given?
      each do |i|
        result = instance_of?(Hash) ? (yield keyhold[indexOf(i)], valuehold[indexOf(i)]) : (yield i)
        return !result if result
      end
    elsif !block_given? && args.empty?
      each do |i|
        result = instance_of?(Hash) ? noin_lambda.call(valuehold[indexOf(i)]) : noin_lambda.call(i)
        return !result if result
      end
    elsif args[0].instance_of?(Regexp)
      each do |i|
        result = instance_of?(Hash) ? !!valuehold[indexOf(i)].match(args[0]) : !!i.match(args[0])
        return !result if result
      end
    elsif args[0].instance_of?(Class)
      each do |i|
        result = instance_of?(Hash) ? !!valuehold[indexOf(i)].instance_of?(args[0]) : !!i.instance_of?(args[0])
        return !result if result
      end
    else
      each do |i|
        result = instance_of?(Hash) ? (valuehold[indexOf(i)] == args[0]) : (i == args[0])
        return !result if result
      end
    end

    if block_given?
      each do |i|
        result = instance_of?(Hash) ? (yield keyhold[indexOf(i)], valuehold[indexOf(i)]) : (yield i)
        return !result if result
      end
    elsif !block_given? && args.empty?
      each do |i|
        result = instance_of?(Hash) ? noin_lambda.call(valuehold[indexOf(i)]) : noin_lambda.call(i)
        return !result if result
      end
    elsif args[0].instance_of?(Regexp)
      each do |i|
        result = instance_of?(Hash) ? !!valuehold[indexOf(i)].match(args[0]) : !!i.match(args[0])
        return !result if result
      end
    elsif args[0].instance_of?(Class)
      each do |i|
        result = instance_of?(Hash) ? !!valuehold[indexOf(i)].instance_of?(args[0]) : !!i.instance_of?(args[0])
        return !result if result
      end
    else
      each do |i|
        result = instance_of?(Hash) ? (valuehold[indexOf(i)] == args[0]) : (i == args[0])
        return !result if result
      end
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
      to_enum
    end
  end

  def my_count(*args)
    j = 0
    if !block_given?
      j = if args.empty?
            puts args
            self.each do
              j += 1
            end
          else
            self.each do |h|
              j += 1 if h == rule[0]
            end
          end
    elsif block_given? && args.empty?
      each do |k|
        j += 1 if yield k
      end
    end
    j
  end

  def my_inject(*args)
    raise LocalJumpError, 'no block given' if !block_given? && args.empty?

    symbol = 0
    initial = 0
    args.each do |j|
      symbol = j if j.instance_of?(Symbol)
      initial = j unless j.instance_of?(Symbol)
    end
    if block_given?
      x = 0
      each do |j|
        initial = initial.zero? ? j : (yield initial, j) if x.zero?
        initial = yield initial, j unless x.zero?
        x += 1
      end
    else
      my_lambda = case symbol
                  when :+
                    ->(init, num) { init + num }
                  when :-
                    ->(init, num) { init - num }
                  when :/
                    ->(init, num) { init / num }
                  when :*
                    ->(init, num) { init * num }
                  when :%
                    ->(init, num) { init % num }
                  end
      x = 0
      each do |j|
        initial = initial.zero? ? j : my_lambda.call(initial, j) if x.zero?
        initial = my_lambda.call(initial, j) unless x.zero?
        x += 1
      end
    end
    initial
  end
end

def multiply_els(arr)
  arr.my_inject { |res, num| res * num }
end

# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/ModuleLength
# rubocop:enable Style/DoubleNegation
array = [1, 3, 5, 6, 4, 4, 4 ,18 ,17 ,10]
puts array.my_count {|j| j < 10}