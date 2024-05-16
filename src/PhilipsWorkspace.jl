module PhilipsWorkspace

using JSON

# Create custom struct to wrap a workspace dictionary
struct Workspace
    dict::Dict
end

# Overload getindex to access values of a Workspace in the same way as a dictionary
Base.getindex(workspace::Workspace, key) = workspace.dict[key]

export Workspace

include("reader.jl")
export read_workspace

include("objects.jl")
export get_object
export get_all_objects_of_type

include("parameters.jl")
export get_parameter_value
export get_parameter_group

include("utils.jl")

end
