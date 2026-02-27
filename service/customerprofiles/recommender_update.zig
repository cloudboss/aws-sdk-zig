const RecommenderConfig = @import("recommender_config.zig").RecommenderConfig;
const RecommenderStatus = @import("recommender_status.zig").RecommenderStatus;

/// Contains information about an update operation performed on a recommender.
pub const RecommenderUpdate = struct {
    /// The timestamp when this recommender update was initiated.
    created_at: ?i64,

    /// If the update operation failed, provides the reason for the failure.
    failure_reason: ?[]const u8,

    /// The timestamp of when the recommender was edited.
    last_updated_at: ?i64,

    /// The updated configuration settings applied to the recommender during this
    /// update.
    recommender_config: ?RecommenderConfig,

    /// The current status of the recommender update operation.
    status: ?RecommenderStatus,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .failure_reason = "FailureReason",
        .last_updated_at = "LastUpdatedAt",
        .recommender_config = "RecommenderConfig",
        .status = "Status",
    };
};
