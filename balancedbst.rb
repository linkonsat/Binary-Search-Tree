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
        @root = build_tree(@sorted_list)

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
        
        elsif (node.data < value)
            p node.data
            find_node(node.right,value)
        elsif (node.data > value)
            p node.data
            find_node(node.left,value)
        end

    end

    def insert(node = @root,value)
        #identify base case what is a small iteration for if it's an end variable
        if (node.left.nil? && node.right.nil?)
            if (value < node.data)
                node.left = Node.new(value)
            elsif (value > node.data)
                node.right = Node.new(value)
            end
        end
        if(node.data < value)
        insert(node.right,value)
        elsif (node.data > value )
        insert(node.left,value)
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
    

    def pusher(container_list)
        if (!container_list[0].right.nil?)
            container_list.push(container_list[0].right)
        end
        if(!container_list[0].left.nil?)
            container_list.push(container_list[0].left)
        end
    end
    def level_order_recursion(qeueu = [self.root],no_block_return = [],&block)
        no_block_return = no_block_return
        #que is a placeholder for the nodes were traveling through with it defaulting as the initial self.root node
        #set the base case as the queue being empty. DONT FORGET AS YOU GO BACK THROUGH THE RECURSIVE CASES YOU MUST THE QEUEU BACK TO AVOID AN INFINITE LOOP
        if (qeueu.empty?)
            return no_block_return
        else
        qeueu = qeueu
        #if the block is given we do this however need to push the node children regardless to the qeueu to make it available
        if block_given?
        yield qeueu[0]
        #we assign the recursive call results to qeueu as realisticaly we only care about whether or not qeueu is empty or not. first we start with the self.root.
        #pusher checks if the current level has any children and pushes those
        pusher(qeueu)
        qeueu.delete_at(0)
        level_order_recursion(qeueu,no_block_return,&block)
        #after yield the block we push the children if there not null into the qeueu and start the recursive call.

        #else we just display the array as the nodes are traversed 
        else
            qeueu = qeueu
            pusher(qeueu)
            no_block_return.push(qeueu[0])
            qeueu.delete_at(0)
            no_block_return = level_order_recursion(qeueu,no_block_return)
        
        end
    end
    if (no_block_return.empty? == false)
        return no_block_return
    end
    end

    def inorder(tree = self.root, no_block_given = [],&block)
        if (tree.nil?)
            return 
        end
        #traverse the left subtree
     inorder(tree.left,no_block_given,&block)
        #visit the root
        if block_given?
        current_value = tree.data
        yield current_value
        else
           # binding.pry
        no_block_given.push(tree.data)
        #traverse the right subtree
        end
    inorder(tree.right,no_block_given,&block)
            return no_block_given
    end

    def preorder(tree = self.root,no_block_given = [],&block)
        if (tree.nil?)
            return 
        elsif (tree.data == self.root.data)
            if block_given?
        yield tree.data
            else
                no_block_given.push(tree.data)
        end
    end
        #traverse the left subtree
    inorder(tree.left,no_block_given,&block)
        #visit the root
        #traverse the right subtree
    inorder(tree.right,no_block_given,&block)
    if (tree.data != self.root.data)
        if block_given?
    yield tree.data
        else
            no_block_given.push(tree.data)
        end
    end
    return no_block_given
    end

    def postorder(tree = self.root,no_block_given = [],&block)
    #traverse the left subtree
        if (tree.nil?)
            return
        end
    inorder(tree.left,no_block_given,&block)
    #visit the root
    
    #traverse the right subtree
    inorder(tree.right,no_block_given,&block)
    if block_given?
    yield tree.data
    else
        no_block_given.push(tree.data)
    end
    return no_block_given

    end
    #array containing checked nodes
    #array containing height found for each branch
    #question is that we don't want to pass 4 parameters. At a maximum for a clean method 
    #so one way to look at this is how can we further abstract this method out. 
    def height(node, height_num = 0)
        #1. get the node from the tree that we are starting from if it's not the correct class
        if (node != nil && node.class != Node)
            node = find_node(node)
            #1.5 recurisvely return height_num if node has no children
        end
        if(node.nil? || node.left.nil? && node.right.nil?)
            return height_num 
        end
        height_num += 1 
        #4. start a recursive call on the left node to travel down all of it's node
        right_height_value = height(node.right,height_num)
        #5. compare values of left and right recursive values
        left_height_value = left_height(node.left)   
        result = left_height_value > right_height_value ? left_height_value : right_height_value
        #6. return the value of the height of the node
        return result
    end

    def left_height(node,height_num = 0)
        #1. get the node from the tree that we are starting from if it's not the correct class
        if (node != nil && node.class != Node)
            node = find_node(node)
            #1.5 recurisvely return height_num if node has no children
        end
        if(node.nil? || node.left.nil? && node.right.nil?)
            return height_num + 1
        end
        #4. start a recursive call on the left node to travel down all of it's node
        left_height_value = left_height(node.left,height_num)
        #5. compare values of left and right recursive values   
        return left_height_value + 1
    end
    def depth (value,node = self.root, depth = 0)
        #Given a target node of N. We want to start traversing the node path starting from root. by default we know we can start from the root however we need to provide a target node
        if(node.data == value)
            #Once we find the node we return depth to the next recursive call
            return depth 
        #check if the node is greater than the value 
        elsif (node.data > value) 
            depth += 1
            new_depth = depth(value, node.right,depth)
        elsif (node.data < value)
            depth += 1
            new_depth =depth(value,node.left,depth)
        end
        return new_depth
    end

    def balanced?
        result = true
        self.level_order_recursion do |item|
            left_height = height(item.left)
            right_height = height(item.right)
        if(!(left_height - 1..left_height + 1).include?(right_height) || !(right_height - 1..right_height + 1).include?(left_height))
            return false
        end
    end
    return result
    end

    def rebalance
        #new_values = self.postorder
        self.sorted_list = merge_sort(self.inorder)
        self.root = build_tree(@sorted_list)
        binding.pry
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
            combined_list.push(sort_right(split_list[1], -1, []))

        end
       
       combined_list = final_sort([combined_list[0].reverse,combined_list[1].reverse],0,[])
       #binding.pry
        return combined_list
    end

    def sort_left(left_side,count,sorted_items_left)
       # binding.pry
        if (count == -1)
            left_side.each_with_index do | item, index |
                if(left_side[index+1] != nil)
                   # binding.pry
            left_side[index..index + 1]  =  item > left_side[index + 1] ? [[left_side[index],left_side[index+1]]] : [[left_side[index+1],left_side[index]]]
                end
                end
                count += 1
            end
        if(left_side.length != count)
            new_left_side = left_side.flatten
            item = new_left_side[count]
            i = 0
            until i == new_left_side.length
                if (new_left_side[i] > item && sorted_items_left.count(new_left_side[i]) != 1)
                    sorted_items_left.push(new_left_side[i])
                end
               i += 1
            end
            count += 1
            
            sort_left(new_left_side,count,sorted_items_left)
        elsif(count == left_side.flatten.length)
            return sorted_items_left
        end
    end
    def sort_right(right_side,count,sorted_items_right)
        if (count == -1)
            right_side.each_with_index do | item, index |
    
                if(right_side[index+1] != nil)
            right_side[index..index + 1]  =  item > right_side[index + 1] ? [[right_side[index],right_side[index+1]]] : [[right_side[index+1],right_side[index]]]
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
                if (new_right_side[i] > item && sorted_items_right.count(right_side[i]) != 1)
                    sorted_items_right.push(new_right_side[i])
                end
                i += 1
            end
            count += 1
            sort_right(new_right_side,count,sorted_items_right)
        elsif(right_side.flatten.length == count)
        return sorted_items_right
        end
    end
  

    def final_sort(combined_list,count, sorted_items_all)
        #binding.pry
        i = 0
        item = combined_list.flatten[count]
        until i == combined_list.flatten.length 
            #binding.pry
            if(combined_list.flatten[i] < item && sorted_items_all.count(combined_list[i]) != 1)
                sorted_items_all.push(combined_list.flatten[i])
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


new_tree = BalancedTree.new([50000000,45654,3000,2345,800,700,600,500,2000,1000,250,200,150,100,67,64.5,39,25,29,22,14,13,12,11,10.5,10,9,8,7,6,5,4,3,2,1,10000,11000,12000])
new_tree.build_tree()
array = []

result = new_tree.level_order_recursion
is_balanced = new_tree.balanced?
new_tree.pretty_print
binding.pry
new_tree.insert(88)
p new_tree
new_tree.insert(88)
p new_tree
p new_tree.pretty_print
