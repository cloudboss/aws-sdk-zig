const IntervalPeriod = @import("interval_period.zig").IntervalPeriod;

/// The interval period with the start and end time for the metrics.
pub const MetricInterval = struct {
    /// The timestamp, in UNIX Epoch time format. End time is based on the interval
    /// period selected. For example, If
    /// `IntervalPeriod` is selected `THIRTY_MIN`, `StartTime` and `EndTime` in
    /// the API request differs by 1 day, then 48 results are returned in the
    /// response. Each result is aggregated by the 30
    /// minutes period, with each `StartTime` and `EndTime` differing by 30 minutes.
    end_time: ?i64 = null,

    /// The interval period provided in the API request.
    interval: ?IntervalPeriod = null,

    /// The timestamp, in UNIX Epoch time format. Start time is based on the
    /// interval period selected.
    start_time: ?i64 = null,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .interval = "Interval",
        .start_time = "StartTime",
    };
};
