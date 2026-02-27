pub const RuleApplyOrder = enum {
    before_account_rules,
    after_account_rules,

    pub const json_field_names = .{
        .before_account_rules = "BEFORE_ACCOUNT_RULES",
        .after_account_rules = "AFTER_ACCOUNT_RULES",
    };
};
