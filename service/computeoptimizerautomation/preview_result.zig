const ResourceDetails = @import("resource_details.zig").ResourceDetails;
const EstimatedMonthlySavings = @import("estimated_monthly_savings.zig").EstimatedMonthlySavings;
const RecommendedActionType = @import("recommended_action_type.zig").RecommendedActionType;
const Tag = @import("tag.zig").Tag;
const ResourceType = @import("resource_type.zig").ResourceType;

/// Contains the results of previewing an automation rule against available
/// recommendations.
pub const PreviewResult = struct {
    /// The Amazon Web Services account ID associated with the resource.
    account_id: ?[]const u8 = null,

    current_resource_details: ?ResourceDetails = null,

    /// A summary of the resource's current configuration.
    current_resource_summary: ?[]const u8 = null,

    estimated_monthly_savings: ?EstimatedMonthlySavings = null,

    /// The number of days of historical data used to analyze the resource.
    look_back_period_in_days: ?i32 = null,

    /// The ID of the recommended action being previewed.
    recommended_action_id: ?[]const u8 = null,

    /// The type of recommended action being previewed.
    recommended_action_type: ?RecommendedActionType = null,

    recommended_resource_details: ?ResourceDetails = null,

    /// A summary of the resource's recommended configuration.
    recommended_resource_summary: ?[]const u8 = null,

    /// The Amazon Web Services Region where the resource is located.
    region: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the resource affected by the recommended
    /// action.
    resource_arn: ?[]const u8 = null,

    /// The ID of the resource affected by the recommended action.
    resource_id: ?[]const u8 = null,

    /// The tags associated with the resource.
    resource_tags: ?[]const Tag = null,

    /// The type of resource being evaluated.
    resource_type: ?ResourceType = null,

    /// Indicates whether implementing the recommended action requires a resource
    /// restart.
    restart_needed: ?bool = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .current_resource_details = "currentResourceDetails",
        .current_resource_summary = "currentResourceSummary",
        .estimated_monthly_savings = "estimatedMonthlySavings",
        .look_back_period_in_days = "lookBackPeriodInDays",
        .recommended_action_id = "recommendedActionId",
        .recommended_action_type = "recommendedActionType",
        .recommended_resource_details = "recommendedResourceDetails",
        .recommended_resource_summary = "recommendedResourceSummary",
        .region = "region",
        .resource_arn = "resourceArn",
        .resource_id = "resourceId",
        .resource_tags = "resourceTags",
        .resource_type = "resourceType",
        .restart_needed = "restartNeeded",
    };
};
