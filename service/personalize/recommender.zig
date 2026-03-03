const aws = @import("aws");

const RecommenderUpdateSummary = @import("recommender_update_summary.zig").RecommenderUpdateSummary;
const RecommenderConfig = @import("recommender_config.zig").RecommenderConfig;

/// Describes a recommendation generator for a Domain dataset group. You create
/// a recommender in a Domain dataset group
/// for a specific domain use case (domain recipe), and specify the recommender
/// in a
/// [GetRecommendations](https://docs.aws.amazon.com/personalize/latest/dg/API_RS_GetRecommendations.html) request.
pub const Recommender = struct {
    /// The date and time (in Unix format) that the recommender was created.
    creation_date_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the Domain dataset group that contains the
    /// recommender.
    dataset_group_arn: ?[]const u8 = null,

    /// If a recommender fails, the reason behind the failure.
    failure_reason: ?[]const u8 = null,

    /// The date and time (in Unix format) that the recommender was last updated.
    last_updated_date_time: ?i64 = null,

    /// Provides a summary of the latest updates to the recommender.
    latest_recommender_update: ?RecommenderUpdateSummary = null,

    /// Provides evaluation metrics that help you determine the performance
    /// of a recommender. For more information, see
    /// [
    /// Evaluating a
    /// recommender](https://docs.aws.amazon.com/personalize/latest/dg/evaluating-recommenders.html).
    model_metrics: ?[]const aws.map.MapEntry(f64) = null,

    /// The name of the recommender.
    name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the recipe (Domain dataset group use case)
    /// that the recommender was created for.
    recipe_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the recommender.
    recommender_arn: ?[]const u8 = null,

    /// The configuration details of the recommender.
    recommender_config: ?RecommenderConfig = null,

    /// The status of the recommender.
    ///
    /// A recommender can be in one of the following states:
    ///
    /// * CREATE PENDING > CREATE IN_PROGRESS > ACTIVE -or- CREATE FAILED
    ///
    /// * STOP PENDING > STOP IN_PROGRESS > INACTIVE > START PENDING > START
    ///   IN_PROGRESS > ACTIVE
    ///
    /// * DELETE PENDING > DELETE IN_PROGRESS
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_date_time = "creationDateTime",
        .dataset_group_arn = "datasetGroupArn",
        .failure_reason = "failureReason",
        .last_updated_date_time = "lastUpdatedDateTime",
        .latest_recommender_update = "latestRecommenderUpdate",
        .model_metrics = "modelMetrics",
        .name = "name",
        .recipe_arn = "recipeArn",
        .recommender_arn = "recommenderArn",
        .recommender_config = "recommenderConfig",
        .status = "status",
    };
};
