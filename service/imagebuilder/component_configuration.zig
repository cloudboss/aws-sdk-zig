const ComponentParameter = @import("component_parameter.zig").ComponentParameter;

/// Configuration details of the component.
pub const ComponentConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the component.
    component_arn: []const u8,

    /// A group of parameter settings that Image Builder uses to configure the
    /// component for a specific
    /// recipe.
    parameters: ?[]const ComponentParameter = null,

    pub const json_field_names = .{
        .component_arn = "componentArn",
        .parameters = "parameters",
    };
};
