const NodeDataType = @import("node_data_type.zig").NodeDataType;

/// A signal that represents a vehicle device such as the engine, heater, and
/// door locks.
/// Data from an actuator reports the state of a certain vehicle device.
///
/// Updating actuator data can change the state of a device. For example, you
/// can
/// turn on or off the heater by updating its actuator data.
pub const Actuator = struct {
    /// A list of possible values an actuator can take.
    allowed_values: ?[]const []const u8 = null,

    /// A specified value for the actuator.
    assigned_value: ?[]const u8 = null,

    /// A comment in addition to the description.
    comment: ?[]const u8 = null,

    /// The specified data type of the actuator.
    data_type: NodeDataType,

    /// The deprecation message for the node or the branch that was moved or
    /// deleted.
    deprecation_message: ?[]const u8 = null,

    /// A brief description of the actuator.
    description: ?[]const u8 = null,

    /// The fully qualified name of the actuator. For example, the fully qualified
    /// name of an
    /// actuator might be `Vehicle.Front.Left.Door.Lock`.
    fully_qualified_name: []const u8,

    /// The specified possible maximum value of an actuator.
    max: ?f64 = null,

    /// The specified possible minimum value of an actuator.
    min: ?f64 = null,

    /// The fully qualified name of the struct node for the actuator if the data
    /// type of the
    /// actuator is `Struct` or `StructArray`. For example, the struct
    /// fully qualified name of an actuator might be
    /// `Vehicle.Door.LockStruct`.
    struct_fully_qualified_name: ?[]const u8 = null,

    /// The scientific unit for the actuator.
    unit: ?[]const u8 = null,

    pub const json_field_names = .{
        .allowed_values = "allowedValues",
        .assigned_value = "assignedValue",
        .comment = "comment",
        .data_type = "dataType",
        .deprecation_message = "deprecationMessage",
        .description = "description",
        .fully_qualified_name = "fullyQualifiedName",
        .max = "max",
        .min = "min",
        .struct_fully_qualified_name = "structFullyQualifiedName",
        .unit = "unit",
    };
};
