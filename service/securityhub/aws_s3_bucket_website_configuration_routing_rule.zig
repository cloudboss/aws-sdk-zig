const AwsS3BucketWebsiteConfigurationRoutingRuleCondition = @import("aws_s3_bucket_website_configuration_routing_rule_condition.zig").AwsS3BucketWebsiteConfigurationRoutingRuleCondition;
const AwsS3BucketWebsiteConfigurationRoutingRuleRedirect = @import("aws_s3_bucket_website_configuration_routing_rule_redirect.zig").AwsS3BucketWebsiteConfigurationRoutingRuleRedirect;

/// A rule for redirecting requests
/// to the website.
pub const AwsS3BucketWebsiteConfigurationRoutingRule = struct {
    /// Provides the condition that must be met in order to apply the routing rule.
    condition: ?AwsS3BucketWebsiteConfigurationRoutingRuleCondition = null,

    /// Provides the rules to redirect the request if the condition in `Condition`
    /// is
    /// met.
    redirect: ?AwsS3BucketWebsiteConfigurationRoutingRuleRedirect = null,

    pub const json_field_names = .{
        .condition = "Condition",
        .redirect = "Redirect",
    };
};
