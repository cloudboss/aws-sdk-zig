/// An annotation for adding a new variable to an Automated Reasoning policy,
/// which can be used in rule expressions.
pub const AutomatedReasoningPolicyAddVariableAnnotation = struct {
    /// A description of what the variable represents and how it should be used in
    /// rules.
    description: []const u8,

    /// The name of the new variable. This name will be used to reference the
    /// variable in rule expressions.
    name: []const u8,

    /// The type of the variable, which can be a built-in type (like string or
    /// number) or a custom type defined in the policy.
    type: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .name = "name",
        .type = "type",
    };
};
