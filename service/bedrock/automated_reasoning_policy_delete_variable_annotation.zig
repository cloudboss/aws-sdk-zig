/// An annotation for removing a variable from an Automated Reasoning policy.
pub const AutomatedReasoningPolicyDeleteVariableAnnotation = struct {
    /// The name of the variable to delete from the policy. The variable must not be
    /// referenced by any rules.
    name: []const u8,

    pub const json_field_names = .{
        .name = "name",
    };
};
