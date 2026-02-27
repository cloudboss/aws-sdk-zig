const aws = @import("aws");

/// The configuration details of a batch inference job.
pub const BatchInferenceJobConfig = struct {
    /// A string to string map specifying the exploration configuration
    /// hyperparameters, including `explorationWeight` and
    /// `explorationItemAgeCutOff`, you want to use to configure the amount of item
    /// exploration Amazon Personalize uses when
    /// recommending items.
    /// See
    /// [User-Personalization](https://docs.aws.amazon.com/personalize/latest/dg/native-recipe-new-item-USER_PERSONALIZATION.html).
    item_exploration_config: ?[]const aws.map.StringMapEntry,

    /// A map of ranking influence values for POPULARITY and FRESHNESS. For each
    /// key, specify a numerical value between 0.0 and 1.0 that determines how much
    /// influence that ranking factor has on the final recommendations. A value
    /// closer to 1.0 gives more weight to the factor, while a value closer to 0.0
    /// reduces its influence.
    ranking_influence: ?[]const aws.map.MapEntry(f64),

    pub const json_field_names = .{
        .item_exploration_config = "itemExplorationConfig",
        .ranking_influence = "rankingInfluence",
    };
};
