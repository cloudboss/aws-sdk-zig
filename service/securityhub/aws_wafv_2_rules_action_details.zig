const AwsWafv2ActionAllowDetails = @import("aws_wafv_2_action_allow_details.zig").AwsWafv2ActionAllowDetails;
const AwsWafv2ActionBlockDetails = @import("aws_wafv_2_action_block_details.zig").AwsWafv2ActionBlockDetails;
const AwsWafv2RulesActionCaptchaDetails = @import("aws_wafv_2_rules_action_captcha_details.zig").AwsWafv2RulesActionCaptchaDetails;
const AwsWafv2RulesActionCountDetails = @import("aws_wafv_2_rules_action_count_details.zig").AwsWafv2RulesActionCountDetails;

/// The action that WAF should take on a web request when it matches a rule's
/// statement.
/// Settings at the web ACL level can override the rule action setting.
pub const AwsWafv2RulesActionDetails = struct {
    /// Instructs WAF to allow the web request.
    allow: ?AwsWafv2ActionAllowDetails,

    /// Instructs WAF to block the web request.
    block: ?AwsWafv2ActionBlockDetails,

    /// Instructs WAF to run a CAPTCHA check against the web request.
    captcha: ?AwsWafv2RulesActionCaptchaDetails,

    /// Instructs WAF to count the web request and then continue evaluating the
    /// request using the remaining rules in the web ACL.
    count: ?AwsWafv2RulesActionCountDetails,

    pub const json_field_names = .{
        .allow = "Allow",
        .block = "Block",
        .captcha = "Captcha",
        .count = "Count",
    };
};
