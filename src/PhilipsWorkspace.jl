module PhilipsWorkspace

using JSON

# Custom struct to wrap a workspace dictionary
struct Workspace
    dict::Dict
end

# Overload getindex to access values of a Workspace like a dictionary
Base.getindex(workspace::Workspace, key) = workspace.dict[key]

export Workspace

include("reader.jl")
export read_workspace

include("objects.jl")
export get_object, get_all_objects_of_type

include("parameters.jl")
export get_parameter_value, get_parameter_group

include("utils.jl")

end
