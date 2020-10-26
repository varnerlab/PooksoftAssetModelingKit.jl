# -- PRIVATE METHODS ---------------------------------------------------------------------------------------------------- #
# ----------------------------------------------------------------------------------------------------------------------- #

# -- PUBLIC METHODS ----------------------------------------------------------------------------------------------------- #
function ternary_price_tree(initialPrice::Float64, treeHeight::Int64, deltaFunction::Function)::PSResult

    # TODO: check - are the args legit?

    # initialize -
    number_of_nodes = Int((3^(treeHeight+1) - 1)/2)
    priceTree = Array{Float64,1}(undef,number_of_nodes)

    # set the current price -
    priceTree[1] = initialPrice

    # main loop -
    for node_index = 1:number_of_nodes
        
        # for this node, what are the delta values?
        (u,m,d) = deltaFunction(treeHeight)

        # TODO: check, is u,m,d values ...

        # what is the current price -
        basePrice = priceTree[node_index]

        # build my kid's prices -
        upValue = u*basePrice
        midValue = m*basePrice
        downValue = d*basePrice

        # set my kids -

        # left -
        leftIndex = 3*node_index - 1
        if (leftIndex<=number_of_nodes)
            priceTree[leftIndex] = upValue
        end

        # mid -
        midIndex = 3*node_index
        if (midIndex<=number_of_nodes)
            priceTree[midIndex] = midValue
        end

        # right 
        rightIndex = 3*node_index + 1
        if (rightIndex<=number_of_nodes)
            priceTree[rightIndex] = downValue
        end
    end

    # return -
    return PSResult{Array{Float64,1}}(priceTree)
end
# ----------------------------------------------------------------------------------------------------------------------- #