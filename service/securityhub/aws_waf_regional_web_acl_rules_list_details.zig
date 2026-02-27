const AwsWafRegionalWebAclRulesListActionDetails = @import("aws_waf_regional_web_acl_rules_list_action_details.zig").AwsWafRegionalWebAclRulesListActionDetails;
const AwsWafRegionalWebAclRulesListOverrideActionDetails = @import("aws_waf_regional_web_acl_rules_list_override_action_details.zig").AwsWafRegionalWebAclRulesListOverrideActionDetails;

/// A combination of `ByteMatchSet`, `IPSet`, and/or `SqlInjectionMatchSet`
/// objects that identify the web requests that you want to allow, block, or
/// count.
pub const AwsWafRegionalWebAclRulesListDetails = struct {
    /// The action that WAF takes when a web request matches all conditions in the
    /// rule, such as allow,
    /// block, or count the request.
    action: ?AwsWafRegionalWebAclRulesListActionDetails,

    /// Overrides the rule evaluation result in the rule group.
    override_action: ?AwsWafRegionalWebAclRulesListOverrideActionDetails,

    /// The order in which WAF evaluates the rules in a web ACL.
    priority: ?i32,

    /// The ID of an WAF Regional rule to associate with a web ACL.
    rule_id: ?[]const u8,

    /// For actions that are associated with a rule, the action that WAF takes when
    /// a web
    /// request matches all conditions in a rule.
    type: ?[]const u8,

    pub const json_field_names = .{
        .action = "Action",
        .override_action = "OverrideAction",
        .priority = "Priority",
        .rule_id = "RuleId",
        .type = "Type",
    };
};
