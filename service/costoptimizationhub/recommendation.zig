const Source = @import("source.zig").Source;
const Tag = @import("tag.zig").Tag;

/// Describes a recommendation.
pub const Recommendation = struct {
    /// The account to which the recommendation applies.
    account_id: ?[]const u8 = null,

    /// The type of tasks that can be carried out by this action.
    action_type: ?[]const u8 = null,

    /// The currency code used for the recommendation.
    currency_code: ?[]const u8 = null,

    /// Describes the current resource.
    current_resource_summary: ?[]const u8 = null,

    /// The current resource type.
    current_resource_type: ?[]const u8 = null,

    /// The estimated monthly cost of the current resource. For Reserved Instances
    /// and Savings Plans, it refers to the cost for eligible usage.
    estimated_monthly_cost: ?f64 = null,

    /// The estimated monthly savings amount for the recommendation.
    estimated_monthly_savings: ?f64 = null,

    /// The estimated savings percentage relative to the total cost over the cost
    /// calculation lookback period.
    estimated_savings_percentage: ?f64 = null,

    /// The effort required to implement the recommendation.
    implementation_effort: ?[]const u8 = null,

    /// The time when the recommendation was last generated.
    last_refresh_timestamp: ?i64 = null,

    /// The ID for the recommendation.
    recommendation_id: ?[]const u8 = null,

    /// The lookback period that's used to generate the recommendation.
    recommendation_lookback_period_in_days: ?i32 = null,

    /// Describes the recommended resource.
    recommended_resource_summary: ?[]const u8 = null,

    /// The recommended resource type.
    recommended_resource_type: ?[]const u8 = null,

    /// The Amazon Web Services Region of the resource.
    region: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) for the recommendation.
    resource_arn: ?[]const u8 = null,

    /// The resource ID for the recommendation.
    resource_id: ?[]const u8 = null,

    /// Whether or not implementing the recommendation requires a restart.
    restart_needed: ?bool = null,

    /// Whether or not implementing the recommendation can be rolled back.
    rollback_possible: ?bool = null,

    /// The source of the recommendation.
    source: ?Source = null,

    /// A list of tags assigned to the recommendation.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .action_type = "actionType",
        .currency_code = "currencyCode",
        .current_resource_summary = "currentResourceSummary",
        .current_resource_type = "currentResourceType",
        .estimated_monthly_cost = "estimatedMonthlyCost",
        .estimated_monthly_savings = "estimatedMonthlySavings",
        .estimated_savings_percentage = "estimatedSavingsPercentage",
        .implementation_effort = "implementationEffort",
        .last_refresh_timestamp = "lastRefreshTimestamp",
        .recommendation_id = "recommendationId",
        .recommendation_lookback_period_in_days = "recommendationLookbackPeriodInDays",
        .recommended_resource_summary = "recommendedResourceSummary",
        .recommended_resource_type = "recommendedResourceType",
        .region = "region",
        .resource_arn = "resourceArn",
        .resource_id = "resourceId",
        .restart_needed = "restartNeeded",
        .rollback_possible = "rollbackPossible",
        .source = "source",
        .tags = "tags",
    };
};
