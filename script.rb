module Enumerable
  def my_each
    i = 0
    while i < self.length
      yield self[i]
      i += 1
    end
  end

  def my_each_with_index
    while i < self.length
      yield self[i], i

      i += 1
    end
  end

  def my_select
    i = 0
    result = []
    while i < self.length
      filter = yield self[i]
      result.push(self[i]) if filter
      i += 1
    end
    result
  end

  def my_all?
    i = 0
    while i < self.length
      result = yield self[i]
      return result unless result

      i += 1
    end
    true
  end

  def my_any?
    i = 0
    while i < self.length
      result = yield self[i]
      return result if result

      i += 1
    end
    false
  end


  def my_none?
    i = 0
    while i < self.length
      result = yield self[i]
      return false if result

      i += 1
    end
    true
  end
end

array = [1, 2, 3, 4, 5, 6, 7, 8, 9]

puts array.my_select {|num| num%3 == 0} 
