/// A time range that specifies when DevOps Guru opens and then closes an
/// anomaly. This
/// is different from `AnomalyTimeRange`, which specifies the time range when
/// DevOps Guru actually observes the anomalous behavior.
pub const AnomalyReportedTimeRange = struct {
    /// The time when an anomaly is closed.
    close_time: ?i64,

    /// The time when an anomaly is opened.
    open_time: i64,

    pub const json_field_names = .{
        .close_time = "CloseTime",
        .open_time = "OpenTime",
    };
};
