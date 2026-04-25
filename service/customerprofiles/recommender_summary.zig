const aws = @import("aws");

const RecommenderUpdate = @import("recommender_update.zig").RecommenderUpdate;
const RecommenderRecipeName = @import("recommender_recipe_name.zig").RecommenderRecipeName;
const RecommenderConfig = @import("recommender_config.zig").RecommenderConfig;
const RecommenderStatus = @import("recommender_status.zig").RecommenderStatus;

/// Provides a summary of a recommender's configuration and current state.
pub const RecommenderSummary = struct {
    /// The timestamp when the recommender was created.
    created_at: ?i64 = null,

    /// A description of the recommender's purpose and characteristics.
    description: ?[]const u8 = null,

    /// If the recommender is in a failed state, provides the reason for the
    /// failure.
    failure_reason: ?[]const u8 = null,

    /// The timestamp of when the recommender was edited.
    last_updated_at: ?i64 = null,

    /// Information about the most recent update performed on the recommender,
    /// including its status and timing.
    latest_recommender_update: ?RecommenderUpdate = null,

    /// The name of the recipe used by this recommender.
    recipe_name: ?RecommenderRecipeName = null,

    /// The configuration settings applied to this recommender.
    recommender_config: ?RecommenderConfig = null,

    /// The name of the recommender.
    recommender_name: ?[]const u8 = null,

    /// The name of the recommender schema associated with this recommender.
    recommender_schema_name: ?[]const u8 = null,

    /// The current operational status of the recommender.
    status: ?RecommenderStatus = null,

    /// The tags used to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .description = "Description",
        .failure_reason = "FailureReason",
        .last_updated_at = "LastUpdatedAt",
        .latest_recommender_update = "LatestRecommenderUpdate",
        .recipe_name = "RecipeName",
        .recommender_config = "RecommenderConfig",
        .recommender_name = "RecommenderName",
        .recommender_schema_name = "RecommenderSchemaName",
        .status = "Status",
        .tags = "Tags",
    };
};
