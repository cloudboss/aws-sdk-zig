/// Describes a rule update that failed.
pub const RuleUpdateFailure = struct {
    /// The failure code.
    failure_code: ?[]const u8,

    /// The failure message.
    failure_message: ?[]const u8,

    /// The ID or ARN of the rule.
    rule_identifier: ?[]const u8,

    pub const json_field_names = .{
        .failure_code = "failureCode",
        .failure_message = "failureMessage",
        .rule_identifier = "ruleIdentifier",
    };
};
