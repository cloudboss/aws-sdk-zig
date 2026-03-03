const AwsWafv2RulesDetails = @import("aws_wafv_2_rules_details.zig").AwsWafv2RulesDetails;
const AwsWafv2VisibilityConfigDetails = @import("aws_wafv_2_visibility_config_details.zig").AwsWafv2VisibilityConfigDetails;

/// Details about an WAFv2 rule group.
pub const AwsWafv2RuleGroupDetails = struct {
    /// The Amazon Resource Name (ARN) of the entity.
    arn: ?[]const u8 = null,

    /// The web ACL capacity units (WCUs) required for this rule group.
    capacity: ?i64 = null,

    /// A description of the rule group that helps with identification.
    description: ?[]const u8 = null,

    /// A unique identifier for the rule group.
    id: ?[]const u8 = null,

    /// The name of the rule group. You cannot change the name of a rule group after
    /// you create it.
    name: ?[]const u8 = null,

    /// The Rule statements used to identify the web requests that you want to
    /// allow, block, or count. Each rule includes one
    /// top-level statement that WAF uses to identify matching web requests, and
    /// parameters that govern how
    /// WAF handles them.
    rules: ?[]const AwsWafv2RulesDetails = null,

    /// Specifies whether the rule group is for an Amazon CloudFront distribution or
    /// for a regional application.
    /// A regional application can be an Application Load Balancer (ALB), an Amazon
    /// API Gateway REST API, an AppSync
    /// GraphQL API, or an Amazon Cognito user pool.
    scope: ?[]const u8 = null,

    /// Defines and enables Amazon CloudWatch metrics and web request sample
    /// collection.
    visibility_config: ?AwsWafv2VisibilityConfigDetails = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .capacity = "Capacity",
        .description = "Description",
        .id = "Id",
        .name = "Name",
        .rules = "Rules",
        .scope = "Scope",
        .visibility_config = "VisibilityConfig",
    };
};
