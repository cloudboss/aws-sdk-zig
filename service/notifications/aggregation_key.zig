/// Key-value collection that indicate how notifications are grouped.
pub const AggregationKey = struct {
    /// Indicates the type of aggregation key.
    name: []const u8,

    /// Indicates the value associated with the aggregation key name.
    value: []const u8,

    pub const json_field_names = .{
        .name = "name",
        .value = "value",
    };
};
