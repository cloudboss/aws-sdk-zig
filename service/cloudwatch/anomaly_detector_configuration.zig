const Range = @import("range.zig").Range;

/// The configuration specifies details about how the anomaly detection model is
/// to be
/// trained, including time ranges to exclude from use for training the model
/// and the time
/// zone to use for the metric.
pub const AnomalyDetectorConfiguration = struct {
    /// An array of time ranges to exclude from use when the anomaly detection model
    /// is
    /// trained. Use this to make sure that events that could cause unusual values
    /// for the
    /// metric, such as deployments, aren't used when CloudWatch creates the model.
    excluded_time_ranges: ?[]const Range,

    /// The time zone to use for the metric. This is useful to enable the model to
    /// automatically account for daylight savings time changes if the metric is
    /// sensitive to
    /// such time changes.
    ///
    /// To specify a time zone, use the name of the time zone as specified in the
    /// standard
    /// tz database. For more information, see [tz
    /// database](https://en.wikipedia.org/wiki/Tz_database).
    metric_timezone: ?[]const u8,

    pub const json_field_names = .{
        .excluded_time_ranges = "ExcludedTimeRanges",
        .metric_timezone = "MetricTimezone",
    };
};
