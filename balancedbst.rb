require 'pry-byebug'
#first we need to create a node class
class Node
    attr_accessor :data, :left, :right, :number_of
    #Now we select the node and want to set left and right to nill
   def initialize(data,left=nil,right=nil)
    @data = data
    @number_of = 1
    @left = left
    @right = right
   end
   
   def changed_val(new_val)
    return new_val
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


    def find_node(node=@root,value)
        if (node == nil)
            return "value not found"
        elsif(node.data == value)
            return node
        
        elsif (node.data > value)
            p node.data
            find_node(node.right,value)
        elsif (node.data < value)
            p node.data
            find_node(node.left,value)
        end

    end

    def insert(node = @root,value)
        #identify base case what is a small iteration for if it's an end variable
        if(node.data == value)
            #increases 
            node.number_of += 1
            return node 
        elsif(node.right != nil && node.right.data > value && !(node.data < value))
        insert(node.right,value)
        elsif (node.left != nil && node.left.data < value && !(node.data > value))
        insert(node.left,value)
        else
            if(node.data > value)
                node_right = Node.new(value)
                node_right.right = node.right
                node.right = node_right
                insert(node_right,node_right.data)
            elsif (node.data < value)
                node_left = Node.new(value)
                node_left.left = node.left
                node.left = node_left
                insert(node_left,node_left.data)
            end
         end 
    end

    def delete(node = self.root, value)
       binding.pry
        if(value == nil)
            return node
        end
        if (node.data > value )
        node.right = delete(node.right,value)
        elsif (node.data < value)
        node.left = delete(node.left,value)
        else
        
            if (self.root.left.nil? && self.root.right.nil?)
                self.root = nil
                return self.root
            elsif (node.left.nil? == false && node.right.nil? == false)
                node.data = node.left.data
                temp = node.left.right
                binding.pry
                node.left = node.left.left  
                if (temp.nil? == false)
                node.left.right = temp
                end
                
            elsif (node.left.nil?)
                binding.pry
               node = node.right
               delete(node,nil)
            elsif (node.right.nil?)
                binding.pry
                node = node.left
               delete(node,nil)
            end
        end
        return  node    
        
    end
    
    def level_order_recursion(start = self.root)
        qeueu = []
    end
    def merge_sort(tree_items)
        if(tree_items.length == 1)
            return tree_items
        end
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


new_tree = BalancedTree.new([1,2,3,4,5,6,7,8,9])
new_tree.build_tree()
new_tree.pretty_print
new_tree.delete(5)
new_tree.pretty_print
binding.pry
new_tree.insert(88)
p new_tree
new_tree.insert(88)
p new_tree
p new_tree.pretty_print

