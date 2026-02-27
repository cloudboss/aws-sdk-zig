const RecommendationItem = @import("recommendation_item.zig").RecommendationItem;
const RecommendationStatus = @import("recommendation_status.zig").RecommendationStatus;
const TestRisk = @import("test_risk.zig").TestRisk;
const TestType = @import("test_type.zig").TestType;

/// Defines a test recommendation.
pub const TestRecommendation = struct {
    /// Indicates the identifier of the AppComponent.
    app_component_id: ?[]const u8,

    /// Name of the Application Component.
    app_component_name: ?[]const u8,

    /// A list of recommended alarms that are used in the test and must be exported
    /// before or
    /// with the test.
    depends_on_alarms: ?[]const []const u8,

    /// Description for the test recommendation.
    description: ?[]const u8,

    /// Intent of the test recommendation.
    intent: ?[]const u8,

    /// The test recommendation items.
    items: ?[]const RecommendationItem,

    /// Name of the test recommendation.
    name: ?[]const u8,

    /// Prerequisite of the test recommendation.
    prerequisite: ?[]const u8,

    /// Identifier for the test recommendation.
    recommendation_id: ?[]const u8,

    /// Status of the recommended test.
    recommendation_status: ?RecommendationStatus,

    /// Reference identifier for the test recommendation.
    reference_id: []const u8,

    /// Level of risk for this test recommendation.
    risk: ?TestRisk,

    /// Type of test recommendation.
    type: ?TestType,

    pub const json_field_names = .{
        .app_component_id = "appComponentId",
        .app_component_name = "appComponentName",
        .depends_on_alarms = "dependsOnAlarms",
        .description = "description",
        .intent = "intent",
        .items = "items",
        .name = "name",
        .prerequisite = "prerequisite",
        .recommendation_id = "recommendationId",
        .recommendation_status = "recommendationStatus",
        .reference_id = "referenceId",
        .risk = "risk",
        .type = "type",
    };
};
