const RecommenderConfig = @import("recommender_config.zig").RecommenderConfig;

/// Provides a summary of the properties of the recommender.
pub const RecommenderSummary = struct {
    /// The date and time (in Unix format) that the recommender was created.
    creation_date_time: ?i64,

    /// The Amazon Resource Name (ARN) of the Domain dataset group that contains the
    /// recommender.
    dataset_group_arn: ?[]const u8,

    /// The date and time (in Unix format) that the recommender was last updated.
    last_updated_date_time: ?i64,

    /// The name of the recommender.
    name: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the recipe (Domain dataset group use case)
    /// that the recommender was created for.
    recipe_arn: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the recommender.
    recommender_arn: ?[]const u8,

    /// The configuration details of the recommender.
    recommender_config: ?RecommenderConfig,

    /// The status of the recommender. A recommender can be in one of the following
    /// states:
    ///
    /// * CREATE PENDING > CREATE IN_PROGRESS > ACTIVE -or- CREATE FAILED
    ///
    /// * STOP PENDING > STOP IN_PROGRESS > INACTIVE > START PENDING > START
    ///   IN_PROGRESS > ACTIVE
    ///
    /// * DELETE PENDING > DELETE IN_PROGRESS
    status: ?[]const u8,

    pub const json_field_names = .{
        .creation_date_time = "creationDateTime",
        .dataset_group_arn = "datasetGroupArn",
        .last_updated_date_time = "lastUpdatedDateTime",
        .name = "name",
        .recipe_arn = "recipeArn",
        .recommender_arn = "recommenderArn",
        .recommender_config = "recommenderConfig",
        .status = "status",
    };
};
