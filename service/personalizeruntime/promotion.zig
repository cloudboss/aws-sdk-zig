const aws = @import("aws");

/// Contains information on a promotion. A promotion defines additional business
/// rules that apply to a configurable subset of recommended items.
pub const Promotion = struct {
    /// The Amazon Resource Name (ARN) of the filter used by the promotion. This
    /// filter defines the criteria for promoted items. For more information, see
    /// [Promotion
    /// filters](https://docs.aws.amazon.com/personalize/latest/dg/promoting-items.html#promotion-filters).
    filter_arn: ?[]const u8,

    /// The values to use when promoting items.
    /// For each placeholder parameter in your promotion's filter expression,
    /// provide the parameter name (in matching case) as a key and the filter
    /// value(s) as the corresponding value. Separate multiple values for one
    /// parameter with a comma.
    ///
    /// For filter expressions that use an `INCLUDE` element to include items,
    /// you must provide values for all parameters that are defined in the
    /// expression. For
    /// filters with expressions that use an `EXCLUDE` element to exclude items, you
    /// can omit the `filter-values`. In this case, Amazon Personalize doesn't use
    /// that portion of
    /// the expression to filter recommendations.
    ///
    /// For more information on creating filters, see
    /// [Filtering recommendations and user
    /// segments](https://docs.aws.amazon.com/personalize/latest/dg/filter.html).
    filter_values: ?[]const aws.map.StringMapEntry,

    /// The name of the promotion.
    name: ?[]const u8,

    /// The percentage of recommended items to apply the promotion to.
    percent_promoted_items: ?i32,

    pub const json_field_names = .{
        .filter_arn = "filterArn",
        .filter_values = "filterValues",
        .name = "name",
        .percent_promoted_items = "percentPromotedItems",
    };
};
