/// Describes the parameters for a resource type. Use parameters to determine
/// which tasks are
/// identified during target resolution.
pub const TargetResourceTypeParameter = struct {
    /// A description of the parameter.
    description: ?[]const u8,

    /// Indicates whether the parameter is required.
    required: ?bool,

    pub const json_field_names = .{
        .description = "description",
        .required = "required",
    };
};
