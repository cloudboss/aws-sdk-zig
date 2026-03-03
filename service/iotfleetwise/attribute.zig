const NodeDataType = @import("node_data_type.zig").NodeDataType;

/// A signal that represents static information about the vehicle, such as
/// engine type or
/// manufacturing date.
pub const Attribute = struct {
    /// A list of possible values an attribute can be assigned.
    allowed_values: ?[]const []const u8 = null,

    /// A specified value for the attribute.
    assigned_value: ?[]const u8 = null,

    /// A comment in addition to the description.
    comment: ?[]const u8 = null,

    /// The specified data type of the attribute.
    data_type: NodeDataType,

    /// The default value of the attribute.
    default_value: ?[]const u8 = null,

    /// The deprecation message for the node or the branch that was moved or
    /// deleted.
    deprecation_message: ?[]const u8 = null,

    /// A brief description of the attribute.
    description: ?[]const u8 = null,

    /// The fully qualified name of the attribute. For example, the fully qualified
    /// name of an
    /// attribute might be `Vehicle.Body.Engine.Type`.
    fully_qualified_name: []const u8,

    /// The specified possible maximum value of the attribute.
    max: ?f64 = null,

    /// The specified possible minimum value of the attribute.
    min: ?f64 = null,

    /// The scientific unit for the attribute.
    unit: ?[]const u8 = null,

    pub const json_field_names = .{
        .allowed_values = "allowedValues",
        .assigned_value = "assignedValue",
        .comment = "comment",
        .data_type = "dataType",
        .default_value = "defaultValue",
        .deprecation_message = "deprecationMessage",
        .description = "description",
        .fully_qualified_name = "fullyQualifiedName",
        .max = "max",
        .min = "min",
        .unit = "unit",
    };
};
