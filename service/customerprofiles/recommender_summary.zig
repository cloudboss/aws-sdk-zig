const aws = @import("aws");

const RecommenderUpdate = @import("recommender_update.zig").RecommenderUpdate;
const RecommenderRecipeName = @import("recommender_recipe_name.zig").RecommenderRecipeName;
const RecommenderConfig = @import("recommender_config.zig").RecommenderConfig;
const RecommenderStatus = @import("recommender_status.zig").RecommenderStatus;

/// Provides a summary of a recommender's configuration and current state.
pub const RecommenderSummary = struct {
    /// The timestamp when the recommender was created.
    created_at: ?i64,

    /// A description of the recommender's purpose and characteristics.
    description: ?[]const u8,

    /// If the recommender is in a failed state, provides the reason for the
    /// failure.
    failure_reason: ?[]const u8,

    /// The timestamp of when the recommender was edited.
    last_updated_at: ?i64,

    /// Information about the most recent update performed on the recommender,
    /// including its status and timing.
    latest_recommender_update: ?RecommenderUpdate,

    /// The name of the recipe used by this recommender.
    recipe_name: ?RecommenderRecipeName,

    /// The configuration settings applied to this recommender.
    recommender_config: ?RecommenderConfig,

    /// The name of the recommender.
    recommender_name: ?[]const u8,

    /// The current operational status of the recommender.
    status: ?RecommenderStatus,

    /// The tags used to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .description = "Description",
        .failure_reason = "FailureReason",
        .last_updated_at = "LastUpdatedAt",
        .latest_recommender_update = "LatestRecommenderUpdate",
        .recipe_name = "RecipeName",
        .recommender_config = "RecommenderConfig",
        .recommender_name = "RecommenderName",
        .status = "Status",
        .tags = "Tags",
    };
};
