const aws = @import("aws");

/// An object that identifies an item.
///
/// The and APIs return a list of
/// `PredictedItem`s.
pub const PredictedItem = struct {
    /// The recommended item ID.
    item_id: ?[]const u8,

    /// Metadata about the item from your Items dataset.
    metadata: ?[]const aws.map.StringMapEntry,

    /// The name of the promotion that included the predicted item.
    promotion_name: ?[]const u8,

    /// If you use User-Personalization-v2, a list of reasons for why the item was
    /// included in recommendations. Possible reasons include the following:
    ///
    /// * Promoted item - Indicates the item was included as part of a promotion
    ///   that you applied in your recommendation request.
    ///
    /// * Exploration - Indicates the item was included with exploration.
    /// With exploration, recommendations include items with less interactions data
    /// or relevance for the user.
    /// For more information about exploration, see
    /// [Exploration](https://docs.aws.amazon.com/personalize/latest/dg/use-case-recipe-features.html#about-exploration).
    ///
    /// * Popular item - Indicates the item was included as a placeholder popular
    ///   item.
    /// If you use a filter, depending on how many recommendations the filter
    /// removes,
    /// Amazon Personalize might add placeholder items to meet the `numResults` for
    /// your
    /// recommendation request. These items are popular items, based on interactions
    /// data, that satisfy your filter criteria.
    /// They don't have a relevance score for the user.
    reason: ?[]const []const u8,

    /// A numeric representation of the model's certainty that the item will be the
    /// next user
    /// selection. For more information on scoring logic, see how-scores-work.
    score: ?f64,

    pub const json_field_names = .{
        .item_id = "itemId",
        .metadata = "metadata",
        .promotion_name = "promotionName",
        .reason = "reason",
        .score = "score",
    };
};
