/// The Amazon CloudWatch Logs configuration for pentest job logging.
pub const CloudWatchLog = struct {
    /// The name of the CloudWatch log group.
    log_group: ?[]const u8 = null,

    /// The name of the CloudWatch log stream.
    log_stream: ?[]const u8 = null,

    pub const json_field_names = .{
        .log_group = "logGroup",
        .log_stream = "logStream",
    };
};
