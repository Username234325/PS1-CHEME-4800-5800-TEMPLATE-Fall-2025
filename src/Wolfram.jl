# -- PRIVATE API BELOW HERE ------------------------------------------------------------------------ #
function _simulate(algorithm::WolframDeterministicSimulation, rulemodel::MyOneDimensionalElementaryWolframRuleModel, initial::Array{Int64,1}; 
    steps::Int64 = 240, maxnumberofmoves::Union{Int64, Nothing} = nothing, 
    parameters::Union{Nothing, Dict{Int, Float64}} = nothing,
    cooldownlength::Int64 = 0)::Dict{Int64, Array{Int64,2}}
    
    # get stuff from model -
    radius = rulemodel.radius; # how many cells am I looking at?
    number_of_colors = rulemodel.number_of_colors; # how many colors (states) can each cell have?
    width = length(initial); # how many cells are there?

    # initialize -
    frames = Dict{Int64, Array{Int64,2}}();
    frame = Array{Int64,2}(undef, steps, width) |> X -> fill!(X, 0);

    # set the initial state -
    foreach(i -> frame[1,i] = initial[i], 1:width);    
    frames[1] = frame; # set the initial frame -
    
    # TODO: implement the simulation run loop for the deterministic simulation here
    # TODO: Make sure to comment out the throw statement below once you implement this functionality
   
    throw(ErrorException("The simulation run loop for the deterministic simulation has not been implemented yet."));
    

    # return
    return frames;
end

function _simulate(algorithm::WolframStochasticSimulation, rulemodel::MyOneDimensionalElementaryWolframRuleModel, initial::Array{Int64,1}; 
    steps::Int64 = 240, maxnumberofmoves::Union{Int64, Nothing} = nothing, 
    parameters::Union{Nothing, Dict{Int, Float64}} = nothing,
    cooldownlength::Int64 = 0)::Dict{Int64, Array{Int64,2}}

    # get stuff from model
    radius = rulemodel.radius; # how many cells am I looking at?
    number_of_colors = rulemodel.number_of_colors; # how many colors (states) can each cell have?
    width = length(initial); # how many cells are there?
    q = Queue{Int64}(); # which cells will update?

    # initialize -
    frames = Dict{Int64, Array{Int64,2}}();
    frame = Array{Int64,2}(undef, steps, width) |> X -> fill!(X, 0);

    # cooldown -
    cooldown = Dict{Int64, Int64}(); # cooldown for each cell
    foreach(i -> cooldown[i] = 0, 1:width); # initialize cooldown for each cell

    # set the initial state -
    foreach(i -> frame[1,i] = initial[i], 1:width);    
    frames[1] = frame; # set the initial frame

    # TODO: implement the simulation run loop for the stochastic simulation here
    # TODO: Make sure to comment out the throw statement below once you implement this functionality
    throw(ErrorException("The simulation run loop for the stochastic simulation has not been implemented yet."));
    
    # return
    return frames;
end
# -- PRIVATE API ABOVE HERE ------------------------------------------------------------------------ #


# -- PUBLIC API BELOW HERE ------------------------------------------------------------------------ #
"""
    function simulate(rulemodel::MyOneDimensionalElementaryWolframRuleModel, initial::Array{Int64,1};
        steps::Int64 = 24, maxnumberofmoves::Union{Int64, Nothing} = nothing, 
        algorithm::AbstractWolframSimulationAlgorithm)) -> Dict{Int64, Array{Int64,2}}

The simulate function runs a Wolfram simulation based on the provided rule model and initial state.

### Arguments
- `rulemodel::MyOneDimensionalElementaryWolframRuleModel`: The rule model to use for the simulation.
- `initial::Array{Int64,1}`: The initial state of the simulation.
- `steps::Int64`: The number of steps to simulate.
- `maxnumberofmoves::Union{Int64, Nothing}`: The maximum number of moves to simulate.
- `algorithm::AbstractWolframSimulationAlgorithm`: The algorithm to use for the simulation.

### Returns
- A dictionary mapping step numbers to the state of the simulation at that step.
"""
function simulate(rulemodel::MyOneDimensionalElementaryWolframRuleModel, initial::Array{Int64,1}; 
    steps::Int64 = 24, maxnumberofmoves::Union{Int64, Nothing} = nothing, 
    cooldownlength::Int64 = 0, parameters::Union{Nothing, Dict{Int, Float64}} = nothing,
    algorithm::AbstractWolframSimulationAlgorithm)::Dict{Int64, Array{Int64,2}}

    return _simulate(algorithm, rulemodel, initial; steps=steps, 
        maxnumberofmoves=maxnumberofmoves, cooldownlength=cooldownlength, parameters=parameters);
end
# -- PUBLIC API ABOVE HERE ------------------------------------------------------------------------ #