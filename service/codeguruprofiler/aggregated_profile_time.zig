const AggregationPeriod = @import("aggregation_period.zig").AggregationPeriod;

/// Specifies the aggregation period and aggregation start time for
/// an aggregated profile. An aggregated profile is used to collect posted agent
/// profiles
/// during an aggregation period. There are three possible aggregation periods
/// (1 day,
/// 1 hour, or 5 minutes).
pub const AggregatedProfileTime = struct {
    /// The aggregation period. This indicates the period during which an
    /// aggregation profile
    /// collects posted agent profiles for a profiling group. Use one of three valid
    /// durations that are specified using the ISO 8601 format.
    ///
    /// * `P1D` — 1 day
    ///
    /// * `PT1H` — 1 hour
    ///
    /// * `PT5M` — 5 minutes
    period: ?AggregationPeriod = null,

    /// The time that aggregation of posted agent profiles for a profiling group
    /// starts. The aggregation profile
    /// contains profiles posted by the agent starting at this time for an
    /// aggregation period
    /// specified by the `period` property of the `AggregatedProfileTime`
    /// object.
    ///
    /// Specify `start` using the ISO 8601 format. For example,
    /// 2020-06-01T13:15:02.001Z represents 1 millisecond past June 1, 2020 1:15:02
    /// PM UTC.
    start: ?i64 = null,

    pub const json_field_names = .{
        .period = "period",
        .start = "start",
    };
};
