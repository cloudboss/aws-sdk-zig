const aws = @import("aws");

/// Contains information on a promotion. A promotion defines additional business
/// rules that apply to a configurable subset of recommended items.
pub const RecommenderPromotionalFilter = struct {
    /// The name of the recommender filter to use for the promotion.
    name: ?[]const u8 = null,

    /// The percentage of recommended items to apply the promotion to.
    percent_promoted_items: ?i32 = null,

    /// The name of the promotion.
    promotion_name: ?[]const u8 = null,

    /// The values to use when promoting items. For each placeholder parameter in
    /// your promotion's filter expression, provide the parameter name (in matching
    /// case) as a key and the filter value(s) as the corresponding value. Separate
    /// multiple values for one parameter with a comma.
    values: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .name = "Name",
        .percent_promoted_items = "PercentPromotedItems",
        .promotion_name = "PromotionName",
        .values = "Values",
    };
};
