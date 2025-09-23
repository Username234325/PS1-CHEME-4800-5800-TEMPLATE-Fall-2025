
function build(modeltype::Type{MyOneDimensionalElementaryWolframRuleModel}, 
    data::NamedTuple)::MyOneDimensionalElementaryWolframRuleModel

    # check: do we have the required keys in the data NamedTuple?
    required_fields = (:index, :colors, :radius);
    for field ∈ required_fields
        if haskey(data, field) == false
            @error "Ooops! Missing required field: $field. Cannot build the model, returning nothing."
            return nothing; # Early return we cannot build the model, so return nothing
        end
    end

    # Checks: we have the required keys in the data NamedTuple, we should check that they are of the correct type
    # ...

    # initialize -
    index = data.index;
    colors = data.colors;
    radius = data.radius;

    # create an empty model instance -
    model = modeltype();
    rule = Dict{Int,Int}(); # key: neighborhood state, value: resulting state

    # total number of neighborhood configurations
    number_of_states = colors^radius;
    # digits() gives us the expansion of index (least significant digit first), pad to number_of_states length
    states = digits(index, base=colors, pad=number_of_states);
    # build the rule dictionary -
    for i ∈ 0:number_of_states-1
        rule[i] = states[i+1]; 
    end
    
    # set the data on the object
    model.index = index;
    model.rule = rule;
    model.radius = radius;
    model.number_of_colors = colors;

    # return
    return model;
end


