/// A workflow parameter.
pub const WorkflowParameter = struct {
    /// The parameter's description.
    description: ?[]const u8,

    /// Whether the parameter is optional.
    optional: ?bool,

    pub const json_field_names = .{
        .description = "description",
        .optional = "optional",
    };
};
