def my_each(array)
  i = 0
  while i < array.length
    yield array[i]

    i += 1
  end
end

def my_each_with_index(array)
  i = 0
  while i < array.length
    yield array[i], i

    i += 1
  end
end

def my_select(array)
  i = 0
  result = []
  while i < array.length
    filter = yield array[i]
    result.push(array[i]) if filter
    i += 1
  end
  result
end

def my_all?(array)
  i = 0
  while i < array.length
    result = yield array[i]
    return result unless result

    i += 1
  end
  true
end

def my_any?(array)
  i = 0
  while i < array.length
    result = yield array[i]
    return result if result

    i += 1
  end
  false
end


def my_none?(array)
  i = 0
  while i < array.length
    result = yield array[i]
    return false if result

    i += 1
  end
  true
end

array = [1, 1, 2, 2]
puts my_none?(array) { |num| (num % 3).zero? }

array = [1, 2, 4, 7]
puts my_any?(array) { |num| (num % 3).zero? }

