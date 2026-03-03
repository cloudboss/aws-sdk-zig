/// Represents a formal logic rule in an Automated Reasoning policy. For
/// example, rules can be expressed as if-then statements that define logical
/// constraints.
pub const AutomatedReasoningPolicyDefinitionRule = struct {
    /// The human-readable form of the rule expression, often in natural language or
    /// simplified notation.
    alternate_expression: ?[]const u8 = null,

    /// The formal logic expression of the rule.
    expression: []const u8,

    /// The unique identifier of the rule within the policy.
    id: []const u8,

    pub const json_field_names = .{
        .alternate_expression = "alternateExpression",
        .expression = "expression",
        .id = "id",
    };
};
