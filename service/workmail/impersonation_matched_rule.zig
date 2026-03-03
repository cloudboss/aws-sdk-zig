/// The impersonation rule that matched the input.
pub const ImpersonationMatchedRule = struct {
    /// The ID of the rule that matched the input
    impersonation_rule_id: ?[]const u8 = null,

    /// The name of the rule that matched the input.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .impersonation_rule_id = "ImpersonationRuleId",
        .name = "Name",
    };
};
