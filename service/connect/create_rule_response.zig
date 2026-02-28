pub const CreateRuleResponse = struct {
    /// The Amazon Resource Name (ARN) of the rule.
    rule_arn: []const u8,

    /// A unique identifier for the rule.
    rule_id: []const u8,

    pub const json_field_names = .{
        .rule_arn = "RuleArn",
        .rule_id = "RuleId",
    };
};
