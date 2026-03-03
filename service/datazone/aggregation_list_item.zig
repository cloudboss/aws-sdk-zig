/// An aggregation list item.
pub const AggregationListItem = struct {
    /// An attribute on which to compute aggregations.
    attribute: []const u8,

    /// The display value of the aggregation list item. Supported values include
    /// `value` and `glossaryTerm.name`.
    display_value: ?[]const u8 = null,

    pub const json_field_names = .{
        .attribute = "attribute",
        .display_value = "displayValue",
    };
};
