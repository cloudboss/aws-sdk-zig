const RuleExecutionResult = @import("rule_execution_result.zig").RuleExecutionResult;

/// Output details listed for a rule execution, such as the rule execution
/// result.
pub const RuleExecutionOutput = struct {
    /// Execution result information listed in the output details for a rule
    /// execution.
    execution_result: ?RuleExecutionResult,

    pub const json_field_names = .{
        .execution_result = "executionResult",
    };
};
