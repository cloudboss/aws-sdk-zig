const IntervalPeriod = @import("interval_period.zig").IntervalPeriod;

/// Information about the interval period to use for returning results.
pub const IntervalDetails = struct {
    /// `IntervalPeriod`: An aggregated grouping applied to request metrics. Valid
    /// `IntervalPeriod` values are: `FIFTEEN_MIN` | `THIRTY_MIN` | `HOUR` |
    /// `DAY` | `WEEK` | `TOTAL`.
    ///
    /// For example, if `IntervalPeriod` is selected `THIRTY_MIN`, `StartTime` and
    /// `EndTime` differs by 1 day, then Amazon Connect returns 48 results in the
    /// response. Each result is
    /// aggregated by the THIRTY_MIN period. By default Amazon Connect aggregates
    /// results based on the `TOTAL`
    /// interval period.
    ///
    /// The following list describes restrictions on `StartTime` and `EndTime` based
    /// on what
    /// `IntervalPeriod` is requested.
    ///
    /// * `FIFTEEN_MIN`: The difference between `StartTime` and `EndTime` must be
    ///   less
    /// than 3 days.
    ///
    /// * `THIRTY_MIN`: The difference between `StartTime` and `EndTime` must be
    ///   less
    /// than 3 days.
    ///
    /// * `HOUR`: The difference between `StartTime` and `EndTime` must be less than
    ///   3
    /// days.
    ///
    /// * `DAY`: The difference between `StartTime` and `EndTime` must be less than
    ///   35
    /// days.
    ///
    /// * `WEEK`: The difference between `StartTime` and `EndTime` must be less than
    ///   35
    /// days.
    ///
    /// * `TOTAL`: The difference between `StartTime` and `EndTime` must be less
    ///   than
    /// 35 days.
    interval_period: ?IntervalPeriod = null,

    /// The timezone applied to requested metrics.
    time_zone: ?[]const u8 = null,

    pub const json_field_names = .{
        .interval_period = "IntervalPeriod",
        .time_zone = "TimeZone",
    };
};
