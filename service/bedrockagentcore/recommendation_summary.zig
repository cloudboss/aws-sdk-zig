const RecommendationStatus = @import("recommendation_status.zig").RecommendationStatus;
const RecommendationType = @import("recommendation_type.zig").RecommendationType;

/// Summary information about a recommendation.
pub const RecommendationSummary = struct {
    /// The timestamp when the recommendation was created.
    created_at: i64,

    /// The description of the recommendation.
    description: ?[]const u8 = null,

    /// The name of the recommendation.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the recommendation.
    recommendation_arn: []const u8,

    /// The unique identifier of the recommendation.
    recommendation_id: []const u8,

    /// The current status of the recommendation.
    status: RecommendationStatus,

    /// The type of recommendation.
    @"type": RecommendationType,

    /// The timestamp when the recommendation was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .description = "description",
        .name = "name",
        .recommendation_arn = "recommendationArn",
        .recommendation_id = "recommendationId",
        .status = "status",
        .@"type" = "type",
        .updated_at = "updatedAt",
    };
};
