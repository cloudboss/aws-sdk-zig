const SeverityTrendsCount = @import("severity_trends_count.zig").SeverityTrendsCount;

/// Contains the aggregated finding values for a specific point in the findings
/// trend timeline.
pub const TrendsValues = struct {
    /// The count of findings organized by severity level for this data point in the
    /// trend timeline.
    severity_trends: SeverityTrendsCount,

    pub const json_field_names = .{
        .severity_trends = "SeverityTrends",
    };
};
