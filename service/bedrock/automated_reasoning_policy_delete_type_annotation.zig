/// An annotation for removing a custom type from an Automated Reasoning policy.
pub const AutomatedReasoningPolicyDeleteTypeAnnotation = struct {
    /// The name of the custom type to delete from the policy. The type must not be
    /// referenced by any variables or rules.
    name: []const u8,

    pub const json_field_names = .{
        .name = "name",
    };
};
