/// The updated Amazon CloudWatch Logs settings for a channel.
pub const CloudWatchLogsUpdateInput = struct {
    /// Specifies whether logging to Amazon CloudWatch Logs is enabled.
    enabled: bool,

    /// The name of the Amazon CloudWatch Logs log group.
    log_group_name: ?[]const u8 = null,

    /// The name of the Amazon CloudWatch Logs log stream.
    log_stream_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .log_group_name = "LogGroupName",
        .log_stream_name = "LogStreamName",
    };
};
