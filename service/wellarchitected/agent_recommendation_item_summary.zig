const RecommendationItemType = @import("recommendation_item_type.zig").RecommendationItemType;

/// Summary of an agent recommendation item, representing an Amazon Web Services
/// resource or recommendation affected by the optimization recommendation.
pub const AgentRecommendationItemSummary = struct {
    /// The timestamp when the recommendation item was created.
    created_at: i64,

    /// The identifier of the user or system that created this recommendation item.
    created_by: []const u8,

    /// The unique identifier of the recommendation item.
    id: []const u8,

    /// The timestamp when the recommendation item was last modified.
    last_modified_at: ?i64 = null,

    /// The identifier of the user or system that last modified this recommendation
    /// item.
    last_modified_by: ?[]const u8 = null,

    /// Metadata containing a snapshot of the resource or recommendation at the time
    /// of generation.
    metadata: []const u8,

    /// The Amazon Resource Name (ARN) of the associated recommendation.
    recommendation_arn: []const u8,

    /// The type of the recommendation item.
    @"type": RecommendationItemType,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .id = "id",
        .last_modified_at = "lastModifiedAt",
        .last_modified_by = "lastModifiedBy",
        .metadata = "metadata",
        .recommendation_arn = "recommendationArn",
        .@"type" = "type",
    };
};
