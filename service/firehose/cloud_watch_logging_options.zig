/// Describes the Amazon CloudWatch logging options for your Firehose stream.
pub const CloudWatchLoggingOptions = struct {
    /// Enables or disables CloudWatch logging.
    enabled: ?bool = null,

    /// The CloudWatch group name for logging. This value is required if CloudWatch
    /// logging
    /// is enabled.
    log_group_name: ?[]const u8 = null,

    /// The CloudWatch log stream name for logging. This value is required if
    /// CloudWatch
    /// logging is enabled.
    log_stream_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .log_group_name = "LogGroupName",
        .log_stream_name = "LogStreamName",
    };
};
