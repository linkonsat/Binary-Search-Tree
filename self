
[1mFrom:[0m /home/macdaniel/Documents/binary_search_trees/balancedbst.rb:70 BalancedTree#insert:

    [1;34m66[0m: [32mdef[0m [1;34minsert[0m(node = @root,value)
    [1;34m67[0m:     [1;34m#identify base case what is a small iteration for if it's an end variable[0m
    [1;34m68[0m:     [32mif[0m(node.data == value)
    [1;34m69[0m:         binding.pry
 => [1;34m70[0m:             node.number_of += [1;34m1[0m
    [1;34m71[0m:         [32mreturn[0m node
    [1;34m72[0m:     [32mend[0m
    [1;34m73[0m:     [32mif[0m(node.right != [1;36mnil[0m && node.right.data > value && !(node.data < value))
    [1;34m74[0m:     insert(node.right,value)
    [1;34m75[0m:     [32melsif[0m (node.left != [1;36mnil[0m && node.left.data < value && !(node.data > value))
    [1;34m76[0m:     insert(node.left,value)
    [1;34m77[0m:     [32melse[0m
    [1;34m78[0m:         [32mif[0m(node.data > value)
    [1;34m79[0m:             node_right = [1;34;4mNode[0m.new(value)
    [1;34m80[0m:             node_right.right = node.right
    [1;34m81[0m:             node.right = node_right
    [1;34m82[0m:             insert(node_right,node_right.data)
    [1;34m83[0m:         [32melsif[0m (node.data < value)
    [1;34m84[0m:             node_left = [1;34;4mNode[0m.new(value)
    [1;34m85[0m:             node_left.left = node.left
    [1;34m86[0m:             node.left = node_left
    [1;34m87[0m:             insert(node_left,node_left.data)
    [1;34m88[0m:         [32mend[0m
    [1;34m89[0m:     [32mend[0m
    [1;34m90[0m: [32mend[0m

