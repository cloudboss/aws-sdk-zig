const aws = @import("aws");

const TrainingDataConfig = @import("training_data_config.zig").TrainingDataConfig;

/// The configuration details of the recommender.
pub const RecommenderConfig = struct {
    /// Whether metadata with recommendations is enabled for the recommender.
    /// If enabled, you can specify the columns from your Items dataset in your
    /// request for recommendations. Amazon Personalize returns this data for each
    /// item in the recommendation response.
    /// For information about enabling metadata for a recommender, see [Enabling
    /// metadata in recommendations for a
    /// recommender](https://docs.aws.amazon.com/personalize/latest/dg/creating-recommenders.html#create-recommender-return-metadata).
    ///
    /// If you enable metadata in recommendations, you will incur additional costs.
    /// For more information, see [Amazon Personalize
    /// pricing](https://aws.amazon.com/personalize/pricing/).
    enable_metadata_with_recommendations: ?bool = null,

    /// Specifies the exploration configuration hyperparameters, including
    /// `explorationWeight` and
    /// `explorationItemAgeCutOff`, you want to use to configure the amount of item
    /// exploration Amazon Personalize uses when
    /// recommending items. Provide `itemExplorationConfig` data only if your
    /// recommenders generate personalized recommendations for a user
    /// (not popular items or similar items).
    item_exploration_config: ?[]const aws.map.StringMapEntry = null,

    /// Specifies the requested minimum provisioned recommendation requests per
    /// second that
    /// Amazon Personalize will support. A high `minRecommendationRequestsPerSecond`
    /// will increase your bill. We recommend starting with 1 for
    /// `minRecommendationRequestsPerSecond` (the default). Track
    /// your usage using Amazon CloudWatch metrics, and increase the
    /// `minRecommendationRequestsPerSecond`
    /// as necessary.
    min_recommendation_requests_per_second: ?i32 = null,

    /// Specifies the training data configuration to use when creating a domain
    /// recommender.
    training_data_config: ?TrainingDataConfig = null,

    pub const json_field_names = .{
        .enable_metadata_with_recommendations = "enableMetadataWithRecommendations",
        .item_exploration_config = "itemExplorationConfig",
        .min_recommendation_requests_per_second = "minRecommendationRequestsPerSecond",
        .training_data_config = "trainingDataConfig",
    };
};
