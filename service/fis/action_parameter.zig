/// Describes a parameter for an action.
pub const ActionParameter = struct {
    /// The parameter description.
    description: ?[]const u8,

    /// Indicates whether the parameter is required.
    required: ?bool,

    pub const json_field_names = .{
        .description = "description",
        .required = "required",
    };
};
