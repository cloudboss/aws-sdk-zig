const TrendsValues = @import("trends_values.zig").TrendsValues;

/// Contains the findings trend metrics data for a specific time point in the
/// requested time period.
pub const TrendsMetricsResult = struct {
    /// The timestamp for this data point in the findings trend metrics.
    timestamp: i64,

    /// The finding trend metric values associated with this timestamp, including
    /// severity counts.
    trends_values: TrendsValues,

    pub const json_field_names = .{
        .timestamp = "Timestamp",
        .trends_values = "TrendsValues",
    };
};
