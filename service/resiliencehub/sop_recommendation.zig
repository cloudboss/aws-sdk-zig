const RecommendationItem = @import("recommendation_item.zig").RecommendationItem;
const RecommendationStatus = @import("recommendation_status.zig").RecommendationStatus;
const SopServiceType = @import("sop_service_type.zig").SopServiceType;

/// Defines a standard operating procedure (SOP) recommendation.
pub const SopRecommendation = struct {
    /// Name of the Application Component.
    app_component_name: ?[]const u8,

    /// Description of the SOP recommendation.
    description: ?[]const u8,

    /// The recommendation items.
    items: ?[]const RecommendationItem,

    /// Name of the SOP recommendation.
    name: ?[]const u8,

    /// Prerequisite for the SOP recommendation.
    prerequisite: ?[]const u8,

    /// Identifier for the SOP recommendation.
    recommendation_id: []const u8,

    /// Status of the recommended standard operating procedure.
    recommendation_status: ?RecommendationStatus,

    /// Reference identifier for the SOP recommendation.
    reference_id: []const u8,

    /// The service type.
    service_type: SopServiceType,

    pub const json_field_names = .{
        .app_component_name = "appComponentName",
        .description = "description",
        .items = "items",
        .name = "name",
        .prerequisite = "prerequisite",
        .recommendation_id = "recommendationId",
        .recommendation_status = "recommendationStatus",
        .reference_id = "referenceId",
        .service_type = "serviceType",
    };
};
