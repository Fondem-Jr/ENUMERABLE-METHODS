module Enumerable
  def my_each
    i = 0
    while i < length
      yield self[i]
      i += 1
    end
  end

  def my_each_with_index
    while i < length
      yield self[i], i

      i += 1
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

  def my_map (*args)
  result=[]
    if args.length == 1
        for i in self
            result.push( args[0].call(i))
        end
    else    
        for i in self
          result.push(yield i)
        end
    end
    result
  end

  def my_count(*args, &block)
    if !block_given? && args.empty?
      i = 0
      each do
        i += 1
      end
      i
    elsif block_given? && args.empty?
      j = 0
      each do |i|
        j += 1 if yield i
      end
      j
    elsif !block_given? && !args.empty?
      j = 0
      for i in self
        j += 1 if i == args[0]
      end
      j
    end
  end

  def my_inject (*args)
    if args.length == 1
      i = yield args[0], self[0]
    else
      i = self[0]
    end
    j = 1
    while j <= self.length - 1
      i = yield i, self[j] 
      j += 1
    end
    return i
  end

end
