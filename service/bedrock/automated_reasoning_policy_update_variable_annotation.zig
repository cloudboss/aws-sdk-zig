/// An annotation for modifying an existing variable in an Automated Reasoning
/// policy.
pub const AutomatedReasoningPolicyUpdateVariableAnnotation = struct {
    /// The new description for the variable, replacing the previous description.
    description: ?[]const u8 = null,

    /// The current name of the variable to update.
    name: []const u8,

    /// The new name for the variable, if you want to rename it. If not provided,
    /// the name remains unchanged.
    new_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "description",
        .name = "name",
        .new_name = "newName",
    };
};
