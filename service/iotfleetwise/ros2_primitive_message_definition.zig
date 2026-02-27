const ROS2PrimitiveType = @import("ros2_primitive_type.zig").ROS2PrimitiveType;

/// Represents a ROS 2 compliant primitive type message of the complex data
/// structure.
pub const ROS2PrimitiveMessageDefinition = struct {
    /// The offset used to calculate the signal value. Combined with scaling, the
    /// calculation
    /// is `value = raw_value * scaling + offset`.
    offset: ?f64,

    /// The primitive type (integer, floating point, boolean, etc.) for the ROS 2
    /// primitive
    /// message definition.
    primitive_type: ROS2PrimitiveType,

    /// A multiplier used to decode the message.
    scaling: ?f64,

    /// An optional attribute specifying the upper bound for `STRING` and
    /// `WSTRING`.
    upper_bound: ?i64,

    pub const json_field_names = .{
        .offset = "offset",
        .primitive_type = "primitiveType",
        .scaling = "scaling",
        .upper_bound = "upperBound",
    };
};
