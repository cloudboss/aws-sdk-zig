const ParameterType = @import("parameter_type.zig").ParameterType;

/// Contains details about a parameter in a function for an action group.
pub const ParameterDetail = struct {
    /// A description of the parameter. Helps the foundation model determine how to
    /// elicit the parameters from the user.
    description: ?[]const u8 = null,

    /// Whether the parameter is required for the agent to complete the function for
    /// action group invocation.
    required: ?bool = null,

    /// The data type of the parameter.
    @"type": ParameterType,

    pub const json_field_names = .{
        .description = "description",
        .required = "required",
        .@"type" = "type",
    };
};
