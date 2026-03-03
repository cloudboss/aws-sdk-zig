const AwsWafRegionalWebAclRulesListDetails = @import("aws_waf_regional_web_acl_rules_list_details.zig").AwsWafRegionalWebAclRulesListDetails;

/// Provides information about the web access control list (web ACL). The web
/// ACL contains the rules that identify the requests that you
/// want to allow, block, or count.
pub const AwsWafRegionalWebAclDetails = struct {
    /// The action to perform if none of the rules contained in the web ACL match.
    default_action: ?[]const u8 = null,

    /// A name for the metrics for this web ACL.
    metric_name: ?[]const u8 = null,

    /// A descriptive name for the web ACL.
    name: ?[]const u8 = null,

    /// An array that contains the action for each rule in a web ACL, the priority
    /// of the rule, and the ID of
    /// the rule.
    rules_list: ?[]const AwsWafRegionalWebAclRulesListDetails = null,

    /// The ID of the web ACL.
    web_acl_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .default_action = "DefaultAction",
        .metric_name = "MetricName",
        .name = "Name",
        .rules_list = "RulesList",
        .web_acl_id = "WebAclId",
    };
};
