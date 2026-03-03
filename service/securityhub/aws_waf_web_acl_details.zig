const AwsWafWebAclRule = @import("aws_waf_web_acl_rule.zig").AwsWafWebAclRule;

/// Provides information about an WAF web access control list (web ACL).
pub const AwsWafWebAclDetails = struct {
    /// The action to perform if none of the rules contained in the web ACL match.
    default_action: ?[]const u8 = null,

    /// A friendly name or description of the web ACL. You can't change the name of
    /// a web ACL after you create it.
    name: ?[]const u8 = null,

    /// An array that contains the action for each rule in a web ACL, the priority
    /// of the rule, and the ID of the rule.
    rules: ?[]const AwsWafWebAclRule = null,

    /// A unique identifier for a web ACL.
    web_acl_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .default_action = "DefaultAction",
        .name = "Name",
        .rules = "Rules",
        .web_acl_id = "WebAclId",
    };
};
