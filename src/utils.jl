"""
    _replace_enumerations!(workspace::Workspace)

For parameters whose datatype is an enumeration, replace the integer values in the workspace
with their corresponding enumeration values.

This function modifies the workspace in place.

# Arguments
- `workspace::Workspace`: The raw GOAL workspace exported with the Export Tool.
"""
function _replace_enumerations!(workspace::Workspace)
    for (name, parameter) in workspace["ParameterWorkspace"]["Parameters"]
        if parameter["DataType"] == "Enum"
            # get the name of the enumeration
            enum_typename = parameter["EnumTypeName"]

            # check if the enumeration exists in the workspace, if not, error
            if !haskey(workspace["WorkspaceEnumerations"], enum_typename)
                error("Enumeration $enum_typename not found in workspace['WorkspaceEnumerations'].")
            end

            # check if the parameter has a range conflict, if so, skip
            if haskey(parameter, "RangeConflict")
                @debug "Parameter $name has a range conflict."
                continue
            end

            # get the allowed values for the enumeration from the workspace
            allowed_texts = workspace["WorkspaceEnumerations"][enum_typename]["AllowedTexts"]

            # check that "Value" is an array of integers
            if !all(x -> x isa Int, parameter["Value"])
                error("Parameter value for enumeration $enum_typename is not an array of integers.")
            end

            # replace the integer values with the actual values
            for (idx, int) in enumerate(parameter["Value"])
                parameter["Value"][idx] = allowed_texts[int+1] # +1 because 0-based indexing
            end
        end
    end

    return nothing
end

"""
    _recursive_only(x)

Recursively apply only on elements of an array until the array is either a scalar or an
array of scalars.
"""
_recursive_only(x::Number) = x
_recursive_only(x::String) = x
function _recursive_only(x::AbstractArray)
    if length(x) == 1
        return _recursive_only(only(x))
    else
        return [_recursive_only(x[i]) for i in eachindex(x)]
    end
end
