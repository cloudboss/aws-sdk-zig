/// Describes a parameter for an action.
pub const ActionParameter = struct {
    /// The parameter description.
    description: ?[]const u8 = null,

    /// Indicates whether the parameter is required.
    required: ?bool = null,

    pub const json_field_names = .{
        .description = "description",
        .required = "required",
    };
};
