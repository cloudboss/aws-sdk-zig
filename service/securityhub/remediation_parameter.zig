/// A parameter used in running the guidance steps.
pub const RemediationParameter = struct {
    /// A description of the parameter.
    description: []const u8,

    /// The name of the parameter.
    name: []const u8,

    /// Specifies whether the parameter is required for running the guidance steps.
    required: ?bool = null,

    /// The type of the parameter.
    @"type": []const u8,

    pub const json_field_names = .{
        .description = "Description",
        .name = "Name",
        .required = "Required",
        .@"type" = "Type",
    };
};
