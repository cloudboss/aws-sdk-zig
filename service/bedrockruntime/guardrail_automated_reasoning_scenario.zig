const GuardrailAutomatedReasoningStatement = @import("guardrail_automated_reasoning_statement.zig").GuardrailAutomatedReasoningStatement;

/// Represents a logical scenario where claims can be evaluated as true or
/// false, containing specific logical assignments.
pub const GuardrailAutomatedReasoningScenario = struct {
    /// List of logical assignments and statements that define this scenario.
    statements: ?[]const GuardrailAutomatedReasoningStatement = null,

    pub const json_field_names = .{
        .statements = "statements",
    };
};
