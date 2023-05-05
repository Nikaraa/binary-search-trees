class Tree
  def initialize
    @root = build_tree
  end

  def build_tree(array)
    sorted_array = array.sort.uniq
    mid = sorted_array.length / 2
    root_return = Node.new(sorted_array[mid])

    root_return.left = build_tree(sorted_array[0...mid])
    root_return.right = build_tree(sorted_array[mid + 1..sorted_array.length])
    root_return
  end

  def insert(value, root = @root)
    return Node.new(value) if @root.nil?

    if root.data > value
      root.left = insert(value, root.left)
    elsif root.data < value
      root.right = insert(value, root.right)
    end
    root
  end

  def delete(value, root = @root)
    return root if @root.nil?

    if root.data < value
      root.right = delete(value, root.right)
    elsif root.data > value
      root.left = delete(value, root.left)
    elsif root.data == value
      if root.left.nil? && root.right.nil?
        root = nil
      elsif root.left.nil?
        root = root.right
      elsif root.right.nil?
        root = root.left
      end
    end
    root
  end

  def find(value, root = @root)
    return current if current == value
    if current > value
      find(value, current.left)
    elsif current < value
      find(value, current.right)
    end
  end

  def level_order
    queue = [@root]
    arr = []
    loop do
      root = queue.shift
      if block_given?
        yield(root)
      else
        arr.push(root.value)
      end
      queue.push(root.left) unless root.left.nil?
      queue.push(root.right) unless root.right.nil?
      break if queue.empty?
    end
  end

  def inorder(root = @root, res = [], &block)
    inorder(root.left, res) if root.left
    if block_given?
      yield(root)
    else
      res.push(root.data)
    end
    inorder(root.right, res) if root.right
    res
  end

  def preorder(root = @root, res = [], &block)
    if block_given?
      yield(root)
    else
      res.push(root.data)
    end
    preorder(root.left, res) if root.left
    preorder(root.right, res) if root.right
    res
  end

  def postorder(root = @root, res = [], &block)
    postorder(root.left, res) if root.left
    postorder(root.right, res) if root.right
    if block_given?
      yield(root)
    else
      res.push(root.data)
    end
    res
  end

  def height(node = @root, level = 0)
    return level if node.nil?

    level += 1
    [height(node.left, level), height(node.right, level)].max
  end

  def depth(node)
    count = 0
    root = @root
    until root.data == node.data
      root = root.left if root.data > node.data
      root = root.right if root.data < node.data
      count += 1
    end
    count
  end

  def balanced?
    left_height = height(@root.left)
    right_height = height(@root.right)
    (left_height - right_height).between?(-1, 1)
  end

  def rebalance
    if balanced?
      return
    else
      values_arr = inorder
      @root = build_tree(values_arr)
    end
  end
end
