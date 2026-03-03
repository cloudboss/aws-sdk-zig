/// Describes a granularity of a metric.
pub const MetricGranularityType = struct {
    /// The granularity. The only valid value is `1Minute`.
    granularity: ?[]const u8 = null,
};
