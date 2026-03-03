/// The action that WAF takes when a web request matches all conditions in the
/// rule, such as allow, block, or count the request.
pub const AwsWafRegionalWebAclRulesListActionDetails = struct {
    /// For actions that are associated with a rule, the action that WAF takes when
    /// a web request matches all conditions in a rule.
    @"type": ?[]const u8 = null,

    pub const json_field_names = .{
        .@"type" = "Type",
    };
};
