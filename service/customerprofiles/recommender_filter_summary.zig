const aws = @import("aws");

const RecommenderFilterStatus = @import("recommender_filter_status.zig").RecommenderFilterStatus;

/// Provides a summary of a recommender filter's configuration and current
/// state.
pub const RecommenderFilterSummary = struct {
    /// The timestamp when the recommender filter was created.
    created_at: ?i64 = null,

    /// A description of the recommender filter's purpose and characteristics.
    description: ?[]const u8 = null,

    /// If the recommender filter is in a failed state, provides the reason for the
    /// failure.
    failure_reason: ?[]const u8 = null,

    /// The filter expression that defines which items to include or exclude from
    /// recommendations.
    recommender_filter_expression: ?[]const u8 = null,

    /// The name of the recommender filter.
    recommender_filter_name: ?[]const u8 = null,

    /// The name of the recommender schema associated with this recommender filter.
    recommender_schema_name: ?[]const u8 = null,

    /// The current operational status of the recommender filter.
    status: ?RecommenderFilterStatus = null,

    /// The tags used to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .description = "Description",
        .failure_reason = "FailureReason",
        .recommender_filter_expression = "RecommenderFilterExpression",
        .recommender_filter_name = "RecommenderFilterName",
        .recommender_schema_name = "RecommenderSchemaName",
        .status = "Status",
        .tags = "Tags",
    };
};
