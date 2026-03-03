/// A workflow parameter.
pub const WorkflowParameter = struct {
    /// The parameter's description.
    description: ?[]const u8 = null,

    /// Whether the parameter is optional.
    optional: ?bool = null,

    pub const json_field_names = .{
        .description = "description",
        .optional = "optional",
    };
};
