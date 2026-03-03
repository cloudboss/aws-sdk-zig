/// An aggregation output item.
pub const AggregationOutputItem = struct {
    /// The count of the aggregation output item.
    count: ?i32 = null,

    /// The display value of the aggregation. If the attribute being aggregated
    /// corresponds to the id of a public resource, the service automatically
    /// resolves the id to the provided display value.
    display_value: ?[]const u8 = null,

    /// The attribute value of the aggregation output item.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .count = "count",
        .display_value = "displayValue",
        .value = "value",
    };
};
