#first we need to create a node class
require 'pry-byebug'
class Node
    attr_accessor :data, :left, :right, :number_of
    #Now we select the node and want to set left and right to nill
   def initialize(data,left=nil,right=nil)
    @data = data
    @number_of = 1
    @left = left
    @right = right
   end

end

class BalancedTree
    #first we need to select the middle element
    attr_accessor :root, :sorted_list
    def initialize(item_list, root=nil)
        @sorted_list = merge_sort(item_list)
        @root = build_tree(item_list,)

    end
    #here is where we can start balancing the tree
    def build_tree(item_list = @sorted_list,root_node = nil)
        #sorted root sorts and removes duplicates from the item list
        if (item_list[0] == nil)
            return nil
        else
        start = 0
        end_of_item_list = item_list.length - 1
        mid = (start + item_list.length) / 2
        #set the root node then start creating a tree node for the left and right side of the array
        #Then after that branch is created attach it to the correct position
        root_node = Node.new(item_list[item_list.length/2])
        root_node.right = build_tree(item_list[0,mid],root_node)    
        root_node.left = build_tree(item_list[mid+1,end_of_item_list],root_node)
        return root_node
        end
        
    end

    def pretty_print(node = @root, prefix = '', is_left = true)
        pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
        pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
      end



    def insert

    end

    def delete

    end

    def merge_sort(tree_items)
        new_list = tree_items
        split_list = [tree_items[0,tree_items.length/2],tree_items[tree_items.length/2,tree_items.length]]
        combined_list = []
        if (combined_list.length == 0)
            combined_list.push(sort_left(split_list[0], -1, []))
            combined_list.push(merge_sort_right =  sort_right(split_list[1], -1, []))

        end
       
       combined_list = final_sort(combined_list,0,[])
        return combined_list
    end

    def sort_left(left_side,count,sorted_items_left)

        if (count == -1)
            left_side.each_with_index do | item, index |
                if(left_side[index+1] != nil)
            left_side[index..index + 1]  =  item > left_side[index + 1] ? [left_side[index+1..index]] : [left_side[index..index+1]]
                else

                    left_side[index] = [left_side[index]]
                end
                end
                count += 1
            end
        if(left_side.length != count)
            new_left_side = left_side.flatten
            item = new_left_side[count]
            i = 0

            until i == new_left_side.length
                if (new_left_side[i] < item && sorted_items_left.count(new_left_side[i]) != 1)
                    sorted_items_left.push(new_left_side[i])
                end
                i += 1
            end
            count += 1
            
            sort_left(new_left_side,count,sorted_items_left)
        elsif(count == left_side.flatten.length)

            sorted_items_left.push(left_side.max)
            return sorted_items_left
        end
    end
    def sort_right(right_side,count,sorted_items_right)
        if (count == -1)
            right_side.each_with_index do | item, index |
    
                if(right_side[index+1] != nil)
            right_side[index..index + 1]  =  item > right_side[index + 1] ? [right_side[index+1..index]] : [right_side[index..index+1]]
            else
                right_side[index] = [right_side[index]]
            end
        end
    end
        if(right_side.flatten.length != count)
            new_right_side = right_side.flatten
            item = new_right_side[count]
            i = 0
            until i == new_right_side.length
                if (new_right_side[i] < item && sorted_items_right.count(right_side[i]) != 1)
                    sorted_items_right.push(new_right_side[i])
                end
                i += 1
            end
            count += 1
            sort_right(new_right_side,count,sorted_items_right)
        elsif(right_side.flatten.length == count)
        sorted_items_right.push(right_side.max)
        return sorted_items_right
        end
    end
  

    def final_sort(combined_list,count, sorted_items_all)
        i = 0
        item = combined_list.flatten[count]
        until i == combined_list.flatten.length 
            if(combined_list.flatten[i] < item && sorted_items_all.count(combined_list[i]) != 1)
                sorted_items_all.push(combined_list[i])
            end
            i += 1
        end
        if (combined_list.length - 1 != count)
            count += 1
            final_sort(combined_list.flatten,count,sorted_items_all)
        else
            sorted_items_all.push(combined_list.max)
            return sorted_items_all
        end
    end
end


new_tree = BalancedTree.new([1, 2,3,4,5,6,7,8,9,10,12,14,15,16,17,18,19,20,21,22,])
new_tree.build_tree()
p new_tree.find_node(222)
binding.pry
new_tree.insert(88)
p new_tree
new_tree.insert(88)
p new_tree
p new_tree.pretty_print