const NodeDataType = @import("node_data_type.zig").NodeDataType;

/// An input component that reports the environmental condition of a vehicle.
///
/// You can collect data about fluid levels, temperatures, vibrations, or
/// battery
/// voltage from sensors.
pub const Sensor = struct {
    /// A list of possible values a sensor can take.
    allowed_values: ?[]const []const u8 = null,

    /// A comment in addition to the description.
    comment: ?[]const u8 = null,

    /// The specified data type of the sensor.
    data_type: NodeDataType,

    /// The deprecation message for the node or the branch that was moved or
    /// deleted.
    deprecation_message: ?[]const u8 = null,

    /// A brief description of a sensor.
    description: ?[]const u8 = null,

    /// The fully qualified name of the sensor. For example, the fully qualified
    /// name of a
    /// sensor might be `Vehicle.Body.Engine.Battery`.
    fully_qualified_name: []const u8,

    /// The specified possible maximum value of the sensor.
    max: ?f64 = null,

    /// The specified possible minimum value of the sensor.
    min: ?f64 = null,

    /// The fully qualified name of the struct node for a sensor if the data type of
    /// the
    /// actuator is `Struct` or `StructArray`. For example, the struct
    /// fully qualified name of a sensor might be `Vehicle.ADAS.CameraStruct`.
    struct_fully_qualified_name: ?[]const u8 = null,

    /// The scientific unit of measurement for data collected by the sensor.
    unit: ?[]const u8 = null,

    pub const json_field_names = .{
        .allowed_values = "allowedValues",
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
