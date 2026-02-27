const ResourcesTrendsValues = @import("resources_trends_values.zig").ResourcesTrendsValues;

/// Contains the resource trend metrics data for a specific time point in the
/// requested time period.
pub const ResourcesTrendsMetricsResult = struct {
    /// The timestamp for this data point in the resources trend metrics.
    timestamp: i64,

    /// The resource trend metric values associated with this timestamp, including
    /// resource counts.
    trends_values: ResourcesTrendsValues,

    pub const json_field_names = .{
        .timestamp = "Timestamp",
        .trends_values = "TrendsValues",
    };
};
