const AutomatedReasoningPolicyTypeValueAnnotation = @import("automated_reasoning_policy_type_value_annotation.zig").AutomatedReasoningPolicyTypeValueAnnotation;

/// An annotation for modifying an existing custom type in an Automated
/// Reasoning policy.
pub const AutomatedReasoningPolicyUpdateTypeAnnotation = struct {
    /// The new description for the custom type, replacing the previous description.
    description: ?[]const u8 = null,

    /// The current name of the custom type to update.
    name: []const u8,

    /// The new name for the custom type, if you want to rename it. If not provided,
    /// the name remains unchanged.
    new_name: ?[]const u8 = null,

    /// The updated list of values for the custom type, which can include additions,
    /// modifications, or removals.
    values: []const AutomatedReasoningPolicyTypeValueAnnotation,

    pub const json_field_names = .{
        .description = "description",
        .name = "name",
        .new_name = "newName",
        .values = "values",
    };
};
