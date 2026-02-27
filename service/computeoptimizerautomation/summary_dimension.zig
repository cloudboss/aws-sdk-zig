const SummaryDimensionKey = @import("summary_dimension_key.zig").SummaryDimensionKey;

/// A key-value pair used to categorize and group summary data for analysis and
/// reporting.
pub const SummaryDimension = struct {
    /// The dimension key used for categorizing summary data.
    key: SummaryDimensionKey,

    /// The specific value for this dimension key used in the summary grouping.
    value: []const u8,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
