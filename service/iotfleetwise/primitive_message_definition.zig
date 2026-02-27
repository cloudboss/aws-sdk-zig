const ROS2PrimitiveMessageDefinition = @import("ros2_primitive_message_definition.zig").ROS2PrimitiveMessageDefinition;

/// Represents a primitive type node of the complex data structure.
pub const PrimitiveMessageDefinition = union(enum) {
    /// Information about a `PrimitiveMessage` using a ROS 2 compliant primitive
    /// type message of the complex data structure.
    ros_2_primitive_message_definition: ?ROS2PrimitiveMessageDefinition,

    pub const json_field_names = .{
        .ros_2_primitive_message_definition = "ros2PrimitiveMessageDefinition",
    };
};
