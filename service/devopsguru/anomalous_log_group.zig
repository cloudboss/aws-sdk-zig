const LogAnomalyShowcase = @import("log_anomaly_showcase.zig").LogAnomalyShowcase;

/// An Amazon CloudWatch log group that contains log anomalies and is used to
/// generate an insight.
pub const AnomalousLogGroup = struct {
    /// The time the anomalous log events stopped.
    impact_end_time: ?i64 = null,

    /// The time the anomalous log events began. The impact start time indicates the
    /// time of the first log anomaly event that occurs.
    impact_start_time: ?i64 = null,

    /// The log anomalies in the log group. Each log anomaly displayed represents a
    /// cluster of similar anomalous log events.
    log_anomaly_showcases: ?[]const LogAnomalyShowcase = null,

    /// The name of the CloudWatch log group.
    log_group_name: ?[]const u8 = null,

    /// The number of log lines that were scanned for anomalous log events.
    number_of_log_lines_scanned: i32 = 0,

    pub const json_field_names = .{
        .impact_end_time = "ImpactEndTime",
        .impact_start_time = "ImpactStartTime",
        .log_anomaly_showcases = "LogAnomalyShowcases",
        .log_group_name = "LogGroupName",
        .number_of_log_lines_scanned = "NumberOfLogLinesScanned",
    };
};
