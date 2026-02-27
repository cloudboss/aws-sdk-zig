/// The parameters for using an CloudWatch Logs log stream as a target.
pub const PipeTargetCloudWatchLogsParameters = struct {
    /// The name of the log stream.
    log_stream_name: ?[]const u8,

    /// The time the event occurred, expressed as the number of milliseconds after
    /// Jan 1, 1970
    /// 00:00:00 UTC.
    timestamp: ?[]const u8,

    pub const json_field_names = .{
        .log_stream_name = "LogStreamName",
        .timestamp = "Timestamp",
    };
};
