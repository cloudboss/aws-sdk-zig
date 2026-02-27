const IdleFinding = @import("idle_finding.zig").IdleFinding;
const IdleRecommendationResourceType = @import("idle_recommendation_resource_type.zig").IdleRecommendationResourceType;
const IdleSavingsOpportunity = @import("idle_savings_opportunity.zig").IdleSavingsOpportunity;
const IdleSavingsOpportunityAfterDiscounts = @import("idle_savings_opportunity_after_discounts.zig").IdleSavingsOpportunityAfterDiscounts;
const Tag = @import("tag.zig").Tag;
const IdleUtilizationMetric = @import("idle_utilization_metric.zig").IdleUtilizationMetric;

/// Describes an Idle resource recommendation.
pub const IdleRecommendation = struct {
    /// The Amazon Web Services account ID of the idle resource.
    account_id: ?[]const u8,

    /// The finding classification of an idle resource.
    finding: ?IdleFinding,

    /// A summary of the findings for the resource.
    finding_description: ?[]const u8,

    /// The timestamp of when the idle resource recommendation was last generated.
    last_refresh_timestamp: ?i64,

    /// The number of days the idle resource utilization metrics were analyzed.
    look_back_period_in_days: f64 = 0,

    /// The ARN of the current idle resource.
    resource_arn: ?[]const u8,

    /// The unique identifier for the resource.
    resource_id: ?[]const u8,

    /// The type of resource that is idle.
    resource_type: ?IdleRecommendationResourceType,

    /// The savings opportunity for the idle resource.
    savings_opportunity: ?IdleSavingsOpportunity,

    /// The savings opportunity for the idle resource after any applying discounts.
    savings_opportunity_after_discounts: ?IdleSavingsOpportunityAfterDiscounts,

    /// A list of tags assigned to your idle resource recommendations.
    tags: ?[]const Tag,

    /// An array of objects that describe the utilization metrics of the idle
    /// resource.
    utilization_metrics: ?[]const IdleUtilizationMetric,

    pub const json_field_names = .{
        .account_id = "accountId",
        .finding = "finding",
        .finding_description = "findingDescription",
        .last_refresh_timestamp = "lastRefreshTimestamp",
        .look_back_period_in_days = "lookBackPeriodInDays",
        .resource_arn = "resourceArn",
        .resource_id = "resourceId",
        .resource_type = "resourceType",
        .savings_opportunity = "savingsOpportunity",
        .savings_opportunity_after_discounts = "savingsOpportunityAfterDiscounts",
        .tags = "tags",
        .utilization_metrics = "utilizationMetrics",
    };
};
