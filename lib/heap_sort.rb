require_relative "heap"

class Array
  def heap_sort!
    (2..self.length).each do |arr_size|
      BinaryMinHeap.heapify_up(self, arr_size - 1, arr_size)

    end
    arr_size = self.length
    until (arr_size < 2)

      self[arr_size -1], self[0] = self[0], self[arr_size - 1]
      BinaryMinHeap.heapify_down(self, 0, arr_size -1)

      arr_size -= 1
    end
    self.reverse!

  end
end
