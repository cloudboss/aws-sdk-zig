const AwsWafv2WebAclCaptchaConfigDetails = @import("aws_wafv_2_web_acl_captcha_config_details.zig").AwsWafv2WebAclCaptchaConfigDetails;
const AwsWafv2WebAclActionDetails = @import("aws_wafv_2_web_acl_action_details.zig").AwsWafv2WebAclActionDetails;
const AwsWafv2RulesDetails = @import("aws_wafv_2_rules_details.zig").AwsWafv2RulesDetails;
const AwsWafv2VisibilityConfigDetails = @import("aws_wafv_2_visibility_config_details.zig").AwsWafv2VisibilityConfigDetails;

/// Details about an WAFv2 web Access Control List (ACL).
pub const AwsWafv2WebAclDetails = struct {
    /// The Amazon Resource Name (ARN) of the web ACL that you want to associate
    /// with the resource.
    arn: ?[]const u8,

    /// The web ACL capacity units (WCUs) currently being used by this web ACL.
    capacity: ?i64,

    /// Specifies how WAF should handle CAPTCHA evaluations for rules that don't
    /// have their own
    /// `CaptchaConfig` settings.
    captcha_config: ?AwsWafv2WebAclCaptchaConfigDetails,

    /// The action to perform if none of the Rules contained in the web ACL match.
    default_action: ?AwsWafv2WebAclActionDetails,

    /// A description of the web ACL that helps with identification.
    description: ?[]const u8,

    /// A unique identifier for the web ACL.
    id: ?[]const u8,

    /// Indicates whether this web ACL is managed by Firewall Manager.
    managedby_firewall_manager: ?bool,

    /// The name of the web ACL.
    name: ?[]const u8,

    /// The Rule statements used to identify the web requests that you want to
    /// allow, block, or count. Each rule includes one
    /// top-level statement that WAF uses to identify matching web requests, and
    /// parameters that govern how
    /// WAF handles them.
    rules: ?[]const AwsWafv2RulesDetails,

    /// Defines and enables Amazon CloudWatch metrics and web request sample
    /// collection.
    visibility_config: ?AwsWafv2VisibilityConfigDetails,

    pub const json_field_names = .{
        .arn = "Arn",
        .capacity = "Capacity",
        .captcha_config = "CaptchaConfig",
        .default_action = "DefaultAction",
        .description = "Description",
        .id = "Id",
        .managedby_firewall_manager = "ManagedbyFirewallManager",
        .name = "Name",
        .rules = "Rules",
        .visibility_config = "VisibilityConfig",
    };
};
