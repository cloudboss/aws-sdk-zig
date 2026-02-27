/// The details of the rule used for evaluating variable values.
pub const EvaluatedRule = struct {
    /// Indicates whether the rule was evaluated.
    evaluated: ?bool,

    /// The rule expression.
    expression: ?[]const u8,

    /// The rule expression value.
    expression_with_values: ?[]const u8,

    /// Indicates whether the rule matched.
    matched: ?bool,

    /// The rule outcome.
    outcomes: ?[]const []const u8,

    /// The rule ID.
    rule_id: ?[]const u8,

    /// The rule version.
    rule_version: ?[]const u8,

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
