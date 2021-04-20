
    def my_each (array) 
        i = 0
        while i < array.length
          yield array[i]
  
          i += 1
           end
    end
  
    array = ['Sharon', 'Leo', 'Leila', 'Brian', 'Arun']
    my_each(array) { |friend| puts "Hello, " + friend }