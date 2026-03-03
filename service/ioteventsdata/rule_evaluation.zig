const SimpleRuleEvaluation = @import("simple_rule_evaluation.zig").SimpleRuleEvaluation;

/// Information needed to evaluate data.
pub const RuleEvaluation = struct {
    /// Information needed to compare two values with a comparison operator.
    simple_rule_evaluation: ?SimpleRuleEvaluation = null,

    pub const json_field_names = .{
        .simple_rule_evaluation = "simpleRuleEvaluation",
    };
};
