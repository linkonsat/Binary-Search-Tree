#first we need to create a node class
require 'pry-byebug'
class Node
    attr_accessor :data, :left, :right
    #Now we select the node and want to set left and right to nill
   def initialize(data,left=nil,right=nil)
    @data = data
    @left = left
    @right = right
   end

end

class BalancedTree
    #first we need to select the middle element
    attr_accessor :root, :left, :right
    def initialize(root=nil)
        sorted_root = merge_sort(root)
        binding.pry 
        @root = Node.new(sorted_root[sorted_root.length/2])
        @left = sorted_root[0,sorted_root.length/2 - 1]
        @right = sorted_root[sorted_root.length/2 + 1, sorted_root.length]
    end
    #here is where we can start balancing the tree
    def build_tree
        build_left_branch(@root,@left)
        build_right_branch(@root, @right)
        return @root
    end

    def build_left_branch(current_node, left)
        #Base condition is if left.mid left and right == nil. We know that we reached the end
        #so we want to move it along by two and access the left and right
        #that ensures we have no repeats but also that if we hit a nill value we can throw an exception

    end
    def build_right_branch(root, right,queue)

    end

    def merge_sort(tree_items)
        new_list = list
        split_list = [[0,tree_items.length/2],[tree_items.length/2,tree_items.length]]
        combined_list = []
        if (combined_list.length == 2)
            merge_sort_left =
            merge_sort_right = 
        end
        return final_sort(combined_list)
    end

    def sort_left(array,count)
    end
    def sort_right(array,count)
    end
    def final_sort(combined_list,count)
    end
end

#so first we will build the root node
new_tree = BalancedTree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])


binding.pry
puts ""