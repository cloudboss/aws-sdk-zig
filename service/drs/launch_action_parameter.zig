const LaunchActionParameterType = @import("launch_action_parameter_type.zig").LaunchActionParameterType;

/// Launch action parameter.
pub const LaunchActionParameter = struct {
    /// Type.
    @"type": ?LaunchActionParameterType,

    /// Value.
    value: ?[]const u8,

    pub const json_field_names = .{
        .@"type" = "type",
        .value = "value",
    };
};
