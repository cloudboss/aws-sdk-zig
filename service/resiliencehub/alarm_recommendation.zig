const RecommendationItem = @import("recommendation_item.zig").RecommendationItem;
const RecommendationStatus = @import("recommendation_status.zig").RecommendationStatus;
const AlarmType = @import("alarm_type.zig").AlarmType;

/// Defines a recommendation for a CloudWatch alarm.
pub const AlarmRecommendation = struct {
    /// Application Component name for the CloudWatch alarm recommendation. This
    /// name is saved as the first
    /// item in the `appComponentNames` list.
    app_component_name: ?[]const u8 = null,

    /// List of Application Component names for the CloudWatch alarm recommendation.
    app_component_names: ?[]const []const u8 = null,

    /// Description of the alarm recommendation.
    description: ?[]const u8 = null,

    /// List of CloudWatch alarm recommendations.
    items: ?[]const RecommendationItem = null,

    /// Name of the alarm recommendation.
    name: []const u8,

    /// The prerequisite for the alarm recommendation.
    prerequisite: ?[]const u8 = null,

    /// Identifier of the alarm recommendation.
    recommendation_id: []const u8,

    /// Status of the recommended Amazon CloudWatch alarm.
    recommendation_status: ?RecommendationStatus = null,

    /// Reference identifier of the alarm recommendation.
    reference_id: []const u8,

    /// Type of alarm recommendation.
    @"type": AlarmType,

    pub const json_field_names = .{
        .app_component_name = "appComponentName",
        .app_component_names = "appComponentNames",
        .description = "description",
        .items = "items",
        .name = "name",
        .prerequisite = "prerequisite",
        .recommendation_id = "recommendationId",
        .recommendation_status = "recommendationStatus",
        .reference_id = "referenceId",
        .@"type" = "type",
    };
};
