/// The details of the rule used for evaluating variable values.
pub const EvaluatedRule = struct {
    /// Indicates whether the rule was evaluated.
    evaluated: ?bool = null,

    /// The rule expression.
    expression: ?[]const u8 = null,

    /// The rule expression value.
    expression_with_values: ?[]const u8 = null,

    /// Indicates whether the rule matched.
    matched: ?bool = null,

    /// The rule outcome.
    outcomes: ?[]const []const u8 = null,

    /// The rule ID.
    rule_id: ?[]const u8 = null,

    /// The rule version.
    rule_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .evaluated = "evaluated",
        .expression = "expression",
        .expression_with_values = "expressionWithValues",
        .matched = "matched",
        .outcomes = "outcomes",
        .rule_id = "ruleId",
        .rule_version = "ruleVersion",
    };
};
