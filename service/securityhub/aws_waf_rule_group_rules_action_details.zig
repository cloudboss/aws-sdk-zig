/// Provides information about what action WAF should take on a web request when
/// it matches the criteria defined in the rule.
pub const AwsWafRuleGroupRulesActionDetails = struct {
    /// The action that WAF should take on a web request when it matches the rule's
    /// statement.
    @"type": ?[]const u8 = null,

    pub const json_field_names = .{
        .@"type" = "Type",
    };
};
