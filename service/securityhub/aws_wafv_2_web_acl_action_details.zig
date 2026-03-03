const AwsWafv2ActionAllowDetails = @import("aws_wafv_2_action_allow_details.zig").AwsWafv2ActionAllowDetails;
const AwsWafv2ActionBlockDetails = @import("aws_wafv_2_action_block_details.zig").AwsWafv2ActionBlockDetails;

/// Specifies the action that Amazon CloudFront or WAF takes when a web request
/// matches the conditions in the rule.
pub const AwsWafv2WebAclActionDetails = struct {
    /// Specifies that WAF should allow requests by default.
    allow: ?AwsWafv2ActionAllowDetails = null,

    /// Specifies that WAF should block requests by default.
    block: ?AwsWafv2ActionBlockDetails = null,

    pub const json_field_names = .{
        .allow = "Allow",
        .block = "Block",
    };
};
