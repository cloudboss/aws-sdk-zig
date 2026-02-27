const RecommenderConfig = @import("recommender_config.zig").RecommenderConfig;

/// Provides a summary of the properties of a recommender update. For a complete
/// listing, call the
/// [DescribeRecommender](https://docs.aws.amazon.com/personalize/latest/dg/API_DescribeRecommender.html) API.
pub const RecommenderUpdateSummary = struct {
    /// The date and time (in Unix format) that the recommender update was created.
    creation_date_time: ?i64,

    /// If a recommender update fails, the reason behind the failure.
    failure_reason: ?[]const u8,

    /// The date and time (in Unix time) that the recommender update was last
    /// updated.
    last_updated_date_time: ?i64,

    /// The configuration details of the recommender update.
    recommender_config: ?RecommenderConfig,

    /// The status of the recommender update. A recommender update can be in one of
    /// the following states:
    ///
    /// CREATE PENDING > CREATE IN_PROGRESS > ACTIVE -or- CREATE FAILED
    status: ?[]const u8,

    pub const json_field_names = .{
        .creation_date_time = "creationDateTime",
        .failure_reason = "failureReason",
        .last_updated_date_time = "lastUpdatedDateTime",
        .recommender_config = "recommenderConfig",
        .status = "status",
    };
};
