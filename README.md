# PhilipsWorkspace

This package is used to read in `workspace.json` files that are exported for each scan with the UMCU Raw Export Tool. The workspace contains all parameter values, object and enumerations. This package uses `JSON.jl` to read in the `.json` file as a Dict and provides functionality to extract objects and parameters in a convenient (`NamedTuple`-based) format.

## Installation

Activate the environment where you want to use this package, enter `Pkg` mode and add the package with the following command:

```julia

add git@gitlab.op.umcutrecht.nl:computational-imaging-lab/philipsworkspace.git
```

## Functionality

```julia
using PhilipsWorkspace

workspace = read_workspace(path_to_workspace_file)

# Get a single instance of an object
SQ_base = get_object("SQ", "base", workspace);

# The object instance is stored as a NamedTuple. Use dot-syntax to access its attributes
SQ_base.dur

# Get all objects of a certain type
RF = get_all_objects_of_type("RF", workspace)

# RF itself is a NamedTuple as well (with each instance being a NamedTuple like before)
RF.ex.str

# Get the value of an individual parameter
EX_PROTO_scan_enable = get_parameter_value("EX_PROTO_scan_enable", workspace)

# Get all parameters of a certain "parameter group"
VAL_FFE = get_parameter_group("VAL", workspace)

```