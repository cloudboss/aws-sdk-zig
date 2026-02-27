pub const RuleType = enum {
    organizational_rule,
    account_rule,

    pub const json_field_names = .{
        .organizational_rule = "ORGANIZATIONAL_RULE",
        .account_rule = "ACCOUNT_RULE",
    };
};
