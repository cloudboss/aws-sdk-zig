const AggregatedValue = @import("aggregated_value.zig").AggregatedValue;

/// Contains success information for an entry that is associated with the
/// [BatchGetAssetPropertyAggregates](https://docs.aws.amazon.com/iot-sitewise/latest/APIReference/API_BatchGetAssetPropertyAggregates.html) API.
pub const BatchGetAssetPropertyAggregatesSuccessEntry = struct {
    /// The requested aggregated asset property values (for example, average,
    /// minimum, and
    /// maximum).
    aggregated_values: []const AggregatedValue,

    /// The ID of the entry.
    entry_id: []const u8,

    pub const json_field_names = .{
        .aggregated_values = "aggregatedValues",
        .entry_id = "entryId",
    };
};
