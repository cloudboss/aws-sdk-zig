const aws = @import("aws");

/// The configuration details of a campaign.
pub const CampaignConfig = struct {
    /// Whether metadata with recommendations is enabled for the campaign.
    /// If enabled, you can specify the columns from your Items dataset in your
    /// request for recommendations. Amazon Personalize returns this data for each
    /// item in the recommendation response.
    /// For information about enabling metadata for a campaign, see [Enabling
    /// metadata in recommendations for a
    /// campaign](https://docs.aws.amazon.com/personalize/latest/dg/campaigns.html#create-campaign-return-metadata).
    ///
    /// If you enable metadata in recommendations, you will incur additional costs.
    /// For more information, see [Amazon Personalize
    /// pricing](https://aws.amazon.com/personalize/pricing/).
    enable_metadata_with_recommendations: ?bool,

    /// Specifies the exploration configuration hyperparameters, including
    /// `explorationWeight` and
    /// `explorationItemAgeCutOff`, you want to use to configure the amount of item
    /// exploration Amazon Personalize uses when
    /// recommending items. Provide `itemExplorationConfig` data only if your
    /// solution uses the
    /// [User-Personalization](https://docs.aws.amazon.com/personalize/latest/dg/native-recipe-new-item-USER_PERSONALIZATION.html) recipe.
    item_exploration_config: ?[]const aws.map.StringMapEntry,

    /// A map of ranking influence values for POPULARITY and FRESHNESS. For each
    /// key, specify a numerical value between 0.0 and 1.0 that determines how much
    /// influence that ranking factor has on the final recommendations. A value
    /// closer to 1.0 gives more weight to the factor, while a value closer to 0.0
    /// reduces its influence.
    ranking_influence: ?[]const aws.map.MapEntry(f64),

    /// Whether the campaign automatically updates to use the latest solution
    /// version (trained model) of a solution. If you specify `True`,
    /// you must specify the ARN of your *solution* for the `SolutionVersionArn`
    /// parameter. It must be in `SolutionArn/$LATEST` format.
    /// The default is `False` and you must manually update the campaign to deploy
    /// the latest solution version.
    ///
    /// For more information about automatic campaign updates, see
    /// [Enabling automatic campaign
    /// updates](https://docs.aws.amazon.com/personalize/latest/dg/campaigns.html#create-campaign-automatic-latest-sv-update).
    sync_with_latest_solution_version: ?bool,

    pub const json_field_names = .{
        .enable_metadata_with_recommendations = "enableMetadataWithRecommendations",
        .item_exploration_config = "itemExplorationConfig",
        .ranking_influence = "rankingInfluence",
        .sync_with_latest_solution_version = "syncWithLatestSolutionVersion",
    };
};
