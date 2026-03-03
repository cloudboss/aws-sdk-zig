const LogAnomalyType = @import("log_anomaly_type.zig").LogAnomalyType;

/// Information about an anomalous log event found within a log group.
pub const LogAnomalyClass = struct {
    /// The explanation for why the log event is considered an anomaly.
    explanation: ?[]const u8 = null,

    /// The token where the anomaly was detected. This may refer to an exception or
    /// another location, or it may be blank for log anomalies such as format
    /// anomalies.
    log_anomaly_token: ?[]const u8 = null,

    /// The type of log anomaly that has been detected.
    log_anomaly_type: ?LogAnomalyType = null,

    /// The ID of the log event.
    log_event_id: ?[]const u8 = null,

    /// The time of the first occurrence of the anomalous log event.
    log_event_timestamp: ?i64 = null,

    /// The name of the Amazon CloudWatch log stream that the anomalous log event
    /// belongs to. A log stream is a sequence of log events that share the same
    /// source.
    log_stream_name: ?[]const u8 = null,

    /// The number of log lines where this anomalous log event occurs.
    number_of_log_lines_occurrences: i32 = 0,

    pub const json_field_names = .{
        .explanation = "Explanation",
        .log_anomaly_token = "LogAnomalyToken",
        .log_anomaly_type = "LogAnomalyType",
        .log_event_id = "LogEventId",
        .log_event_timestamp = "LogEventTimestamp",
        .log_stream_name = "LogStreamName",
        .number_of_log_lines_occurrences = "NumberOfLogLinesOccurrences",
    };
};
