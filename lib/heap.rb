class BinaryMinHeap
  def initialize(&prc)
    @store = []
    @prc = prc || Proc.new { |el1, el2 | el1 <=> el2}
  end

  def count
    @store.length
  end

  def extract
    head = @store.shift
    @store.unshift(@store.pop)

    @store = BinaryMinHeap.heapify_down(@store, 0)
    head


  end

  def peek
    @store
  end

  def push(val)
    @store.push(val)
    @store = BinaryMinHeap.heapify_up(@store, @store.length-1)
    @store
  end

  protected
  attr_accessor :prc, :store

  public
  def self.child_indices(len, parent_index)
    result = []
    child1 = parent_index * 2 + 1
    child2 = parent_index * 2 + 2

    result << child1 if child1 < len
    result << child2 if child2 < len
    return result
  end

  def self.parent_index(child_index)
    parent = (child_index - 1) / 2
    raise "root has no parent" if parent < 0
    return parent

  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    i = 0
    prc ||= Proc.new { |el1, el2 | el1 <=> el2}
      while i < len do
        parent = array[parent_idx]
        child_indices = BinaryMinHeap.child_indices(len, parent_idx)
        break if child_indices.length == 0

        # smallest_child_index = child_indices.min_by{|ci| array[ci]}
        if child_indices.length == 1
          smallest_child_index = child_indices[0]
        else
          if prc.call(array[child_indices[0]], array[child_indices[1]]) == -1
            smallest_child_index = child_indices[0]
          else
            smallest_child_index = child_indices[1]
          end
        end
        child = array[smallest_child_index]
        if smallest_child_index && prc.call(parent, child) == 1
          val = prc.call(parent, child)

          temp = array[parent_idx]
          array[parent_idx] = array[smallest_child_index]
          array[smallest_child_index] = temp
          parent_idx = smallest_child_index
        end
      i += 1
    end
    return array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    i = len -1
    prc ||= Proc.new { |el1, el2 | el1 <=> el2}
      while i > 0 do
        break if child_idx == 0

        current = array[child_idx]
        parent_idx = BinaryMinHeap.parent_index(child_idx)
        parent = array[parent_idx]

        if prc.call(parent, current) == 1

          temp = array[parent_idx]
          array[parent_idx] = array[child_idx]
          array[child_idx] = temp
          child_idx = parent_idx
        end
      i -= 1
    end
    return array
  end
end
