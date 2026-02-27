const AwsWafv2RulesActionDetails = @import("aws_wafv_2_rules_action_details.zig").AwsWafv2RulesActionDetails;
const AwsWafv2VisibilityConfigDetails = @import("aws_wafv_2_visibility_config_details.zig").AwsWafv2VisibilityConfigDetails;

/// Provides details about rules in a rule group. A rule identifies web requests
/// that you want to allow, block, or count. Each rule includes one top-level
/// Statement that WAF uses to identify matching web requests, and parameters
/// that govern how WAF handles them.
pub const AwsWafv2RulesDetails = struct {
    /// The action that WAF should take on a web request when it matches the rule
    /// statement. Settings at the web ACL level can override the rule action
    /// setting.
    action: ?AwsWafv2RulesActionDetails,

    /// The name of the rule.
    name: ?[]const u8,

    /// The action to use in the place of the action that results from the rule
    /// group evaluation.
    override_action: ?[]const u8,

    /// If you define more than one Rule in a WebACL, WAF evaluates each request
    /// against the Rules in order based on the value of `Priority`.
    /// WAF processes rules with lower priority first. The priorities don't need to
    /// be consecutive, but they must all be different.
    priority: ?i32,

    /// Defines and enables Amazon CloudWatch metrics and web request sample
    /// collection.
    visibility_config: ?AwsWafv2VisibilityConfigDetails,

    pub const json_field_names = .{
        .action = "Action",
        .name = "Name",
        .override_action = "OverrideAction",
        .priority = "Priority",
        .visibility_config = "VisibilityConfig",
    };
};
