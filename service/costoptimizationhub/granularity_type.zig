/// The time granularity for aggregating the cost efficiency metrics.
pub const GranularityType = enum {
    /// Metrics are aggregated daily, with each data point representing a single
    /// day's worth of efficiency data. Timestamps are formatted as YYYY-MM-DD.
    daily,
    /// Metrics are aggregated monthly, with each data point representing a full
    /// month's worth of efficiency data. Timestamps are formatted as YYYY-MM.
    monthly,

    pub const json_field_names = .{
        .daily = "DAILY",
        .monthly = "MONTHLY",
    };
};
