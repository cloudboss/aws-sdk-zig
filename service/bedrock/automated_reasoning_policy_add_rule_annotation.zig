/// An annotation for adding a new rule to an Automated Reasoning policy using a
/// formal logical expression.
pub const AutomatedReasoningPolicyAddRuleAnnotation = struct {
    /// The formal logical expression that defines the rule, using mathematical
    /// notation and referencing policy variables and types.
    expression: []const u8,

    pub const json_field_names = .{
        .expression = "expression",
    };
};
