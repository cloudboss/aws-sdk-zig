const AutomatedReasoningLogicStatement = @import("automated_reasoning_logic_statement.zig").AutomatedReasoningLogicStatement;

/// Represents a logical scenario where claims can be evaluated as true or
/// false, containing specific logical assignments.
pub const AutomatedReasoningCheckScenario = struct {
    /// List of logical assignments and statements that define this scenario.
    statements: ?[]const AutomatedReasoningLogicStatement,

    pub const json_field_names = .{
        .statements = "statements",
    };
};
