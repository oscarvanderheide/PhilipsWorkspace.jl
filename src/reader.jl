"""
    read_workspace(path_to_workspace_file::String)

Reads a workspace from a JSON file that is exported using the UMCU Raw Export Tool patch.

# Arguments
- `path_to_workspace_file::String`: The path to the workspace file. The function will remove
  any file extension from the path and append `.json`.

# Returns
- `workspace`: A `Workspace` object that represents the workspace read from the file. All
  integers in the workspace are replaced with their corresponding enumeration values.

# Example
```julia
workspace = read_workspace("/path/to/workspace")
"""
function read_workspace(path_to_workspace_file::String)

    # Remove extension from path, if any
    path, _ = splitext(path_to_workspace_file)

    # Read in the JSON file
    workspace = JSON.parsefile("$path.json")

    # Wrap the workspace in a Workspace struct
    workspace = Workspace(workspace)

    # Replace integers with corresponding enumeration values for parameters
    _replace_enumerations!(workspace)

    return workspace
end
