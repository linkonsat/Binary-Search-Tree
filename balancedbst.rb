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

    end
    def build_right_branch(root, right,queue)

    end

    def merge_sort(tree_items)
        new_list = tree_items
        split_list = [tree_items[0,tree_items.length/2],tree_items[tree_items.length/2,tree_items.length]]
        combined_list = []
        if (combined_list.length == 0)
            #merge_sort_left = sort_left(split_list[0], 0, [])
            merge_sort_right =  sort_right(split_list[1], 0, [])
        end
        return final_sort(combined_list,0,[])
    end

    def sort_left(left_side,count,sorted_items_left)
        if (count == 0)
            left_side.each_with_index do | item, index |
                if(left_side[index+1] != nil)
            left_side[index..index + 1]  =  item > left_side[index + 1] ? [left_side[index+1..index]] : [left_side[index..index+1]]
                else

                    left_side[index] = [left_side[index]]
                end
                end
        end
    end
    def sort_right(right_side,count,sorted_items_right)
        if (count == 0)
            right_side.each_with_index do | item, index |
                if(right_side[index+1] != nil)
            right_side[index..index + 1]  =  item > right_side[index + 1] ? [right_side[index+1..index]] : [right_side[index..index+1]]
            else
                right_side[index] = [right_side[index]]
            end
        end
    end
    binding.pry
    puts "e"
    end
    def final_sort(combined_list,count, sorted_items_all)
    end
end

new_tree = BalancedTree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])


binding.pry
puts ""