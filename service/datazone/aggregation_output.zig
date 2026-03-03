const AggregationOutputItem = @import("aggregation_output_item.zig").AggregationOutputItem;

/// The aggregation for an attribute.
pub const AggregationOutput = struct {
    /// The attribute for this aggregation.
    attribute: ?[]const u8 = null,

    /// The display value of the aggregation output item.
    display_value: ?[]const u8 = null,

    /// A list of aggregation output items.
    items: ?[]const AggregationOutputItem = null,

    pub const json_field_names = .{
        .attribute = "attribute",
        .display_value = "displayValue",
        .items = "items",
    };
};
