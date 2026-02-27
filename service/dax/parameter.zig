const ChangeType = @import("change_type.zig").ChangeType;
const IsModifiable = @import("is_modifiable.zig").IsModifiable;
const NodeTypeSpecificValue = @import("node_type_specific_value.zig").NodeTypeSpecificValue;
const ParameterType = @import("parameter_type.zig").ParameterType;

/// Describes an individual setting that controls some aspect of DAX
/// behavior.
pub const Parameter = struct {
    /// A range of values within which the parameter can be set.
    allowed_values: ?[]const u8,

    /// The conditions under which changes to this parameter can be applied. For
    /// example,
    /// `requires-reboot` indicates that a new value for this parameter will only
    /// take effect if a node is rebooted.
    change_type: ?ChangeType,

    /// The data type of the parameter. For example, `integer`:
    data_type: ?[]const u8,

    /// A description of the parameter
    description: ?[]const u8,

    /// Whether the customer is allowed to modify the parameter.
    is_modifiable: ?IsModifiable,

    /// A list of node types, and specific parameter values for each node.
    node_type_specific_values: ?[]const NodeTypeSpecificValue,

    /// The name of the parameter.
    parameter_name: ?[]const u8,

    /// Determines whether the parameter can be applied to any nodes, or only nodes
    /// of a
    /// particular type.
    parameter_type: ?ParameterType,

    /// The value for the parameter.
    parameter_value: ?[]const u8,

    /// How the parameter is defined. For example, `system` denotes a
    /// system-defined parameter.
    source: ?[]const u8,

    pub const json_field_names = .{
        .allowed_values = "AllowedValues",
        .change_type = "ChangeType",
        .data_type = "DataType",
        .description = "Description",
        .is_modifiable = "IsModifiable",
        .node_type_specific_values = "NodeTypeSpecificValues",
        .parameter_name = "ParameterName",
        .parameter_type = "ParameterType",
        .parameter_value = "ParameterValue",
        .source = "Source",
    };
};
