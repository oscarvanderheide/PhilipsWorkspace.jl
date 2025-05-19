"""
    get_parameter_value(name, workspace)

Get the value of a parameter with the given name from the workspace.

The parameter values are typically stored as arrays with a single element so we recursively
apply `only` to "unwrap" them.

# Arguments
- `name::String`: The name of the parameter.
- `workspace::Workspace`: The workspace containing the parameters.

# Returns
The "unwrapped" value of the parameter.

# Example
    EX_PROTO_scan_enable = get_parameter_value("EX_PROTO_scan_enable", workspace)
"""
function get_parameter_value(name::String, workspace::Workspace)
    val = workspace["ParameterWorkspace"]["Parameters"][name]["Value"]
    return _recursive_only(val)
end

"""
    get_parameter_group(group, workspace)

Get all parameters in a specific group from the workspace.

# Arguments
- `group::String`: The name of the parameter group.
- `workspace::Workspace`: The workspace containing the parameters.

# Returns
A named tuple containing the parameter names and their values.

# Example
    EX_PROTO = get_parameter_group("EX_PROTO", workspace)
    EX_PROTO.scan_enable
"""
function get_parameter_group(group::String, workspace::Workspace)
    # get all parameters from all groups in the workspace
    all_parameters = workspace["ParameterWorkspace"]["Parameters"]
    # extract the parameters that belong to the desired group
    names_in_group = filter(parname -> startswith(parname, group), keys(all_parameters))
    # get the values of the parameters in the group
    values_in_group = get_parameter_value.(names_in_group, (workspace,))
    # remove group prefix from parameter names
    names_in_group = replace.(names_in_group, ("$(group)_" => "",))
    return NamedTuple(Symbol.(names_in_group) .=> values_in_group)
end

# If you want to use `Symbol`s rather than `String`s:
get_parameter_value(name::Symbol, workspace::Workspace) =
    get_parameter_value(string(name), workspace)

get_parameter_group(group::Symbol, workspace::Workspace) =
    get_parameter_group(string(group), workspace)
