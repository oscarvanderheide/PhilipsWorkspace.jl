"""
    get_object(type, instance, workspace)

Extracts attribute names and values for a specific object instance in a workspace.

# Arguments
- `type::String`: The type of the object (e.g. "GR", "RF", "SQ").
- `instance::String`: The instance of the object (e.g. "s_ex", "ex", "base").
- `workspace::Workspace`: The GOAL workspace.

# Returns
A named tuple with attribute names as symbols and attribute values.

# Example
    GR_s_ex = get_object("GR", "s_ex", workspace)
    GR_s_ex.str
"""
function get_object(type::String, instance::String, workspace::Workspace)
    # todo: composite objects
    object_raw = workspace["ObjectWorkspace"][type]["Instances"][instance]["AttributeValues"]

    # extract attribute names and values
    attribute_names_raw = keys(object_raw)
    attribute_values_raw = values(object_raw)

    # remove type prefix from attribute names
    attribute_names = replace.(attribute_names_raw, lowercase("$(type)_") => "")

    # remove nested arrays of length 1
    attribute_values = _recursive_only.(attribute_values_raw)

    return NamedTuple(Symbol.(attribute_names) .=> attribute_values)
end

"""
    get_all_objects_of_type(type, workspace)

Get all objects of a specific type from the workspace.

# Arguments
- `type::String`: The type of objects to retrieve (e.g. "GR", "RF", "SQ").
- `workspace`: The workspace containing the objects.

# Returns
A named tuple where the keys are the names of the instances and the values are the objects.

# Example
    GR = get_all_objects_of_type("GR", workspace)
    GR.s_ex.str
"""
function get_all_objects_of_type(type::String, workspace::Workspace)
    instances = workspace["ObjectWorkspace"][type]["Instances"]
    objects = [get_object(type, instance, workspace) for instance in keys(instances)]

    return NamedTuple(Symbol.(keys(instances)) .=> objects)
end

# If you want to use `Symbol`s rather than `String`s:
get_object(type::Symbol, instance::Symbol, workspace::Workspace) =
    get_object(string(type), string(instance), workspace)

get_all_objects_of_type(type::Symbol, workspace::Workspace) =
    get_all_objects_of_type(string(type), workspace)
