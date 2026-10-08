/// Configuration for Amazon CloudWatch Logs logging.
pub const CloudWatchLogging = struct {
    /// The name of the CloudWatch Logs log group to send logs to.
    log_group: ?[]const u8 = null,

    /// The name of the CloudWatch Logs log stream within the log group.
    log_stream: ?[]const u8 = null,

    pub const json_field_names = .{
        .log_group = "logGroup",
        .log_stream = "logStream",
    };
};
