/// Details of an execution parameter value that is passed to a self-service
/// action when executed on a provisioned product.
pub const ExecutionParameter = struct {
    /// The default values for the execution parameter.
    default_values: ?[]const []const u8 = null,

    /// The name of the execution parameter.
    name: ?[]const u8 = null,

    /// The execution parameter type.
    @"type": ?[]const u8 = null,

    pub const json_field_names = .{
        .default_values = "DefaultValues",
        .name = "Name",
        .@"type" = "Type",
    };
};
