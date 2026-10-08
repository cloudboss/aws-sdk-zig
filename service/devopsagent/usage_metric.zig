/// Represents a usage metric with its configured limit and current usage value.
pub const UsageMetric = struct {
    /// Configured limit for this metric. A value of -1 indicates no limit is
    /// enforced.
    limit: i32,

    /// Current usage for this metric
    usage: f64,

    pub const json_field_names = .{
        .limit = "limit",
        .usage = "usage",
    };
};
