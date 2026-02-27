/// A time range that specifies when the observed unusual behavior in an anomaly
/// started
/// and ended. This is different from `AnomalyReportedTimeRange`, which
/// specifies
/// the time range when DevOps Guru opens and then closes an anomaly.
pub const AnomalyTimeRange = struct {
    /// The time when the anomalous behavior ended.
    end_time: ?i64,

    /// The time when the anomalous behavior started.
    start_time: i64,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .start_time = "StartTime",
    };
};
