const ConditionExecution = @import("condition_execution.zig").ConditionExecution;
const RuleState = @import("rule_state.zig").RuleState;

/// Information about the state of the condition.
pub const ConditionState = struct {
    /// The state of the latest run of the rule.
    latest_execution: ?ConditionExecution = null,

    /// The state of the rules for the condition.
    rule_states: ?[]const RuleState = null,

    pub const json_field_names = .{
        .latest_execution = "latestExecution",
        .rule_states = "ruleStates",
    };
};
