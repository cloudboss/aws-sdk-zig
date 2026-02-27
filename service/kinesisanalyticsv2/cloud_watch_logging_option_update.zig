/// Describes the Amazon CloudWatch logging option updates.
pub const CloudWatchLoggingOptionUpdate = struct {
    /// The ID of the CloudWatch logging option to update
    cloud_watch_logging_option_id: []const u8,

    /// The Amazon Resource Name (ARN) of the CloudWatch log to receive application
    /// messages.
    log_stream_arn_update: ?[]const u8,

    pub const json_field_names = .{
        .cloud_watch_logging_option_id = "CloudWatchLoggingOptionId",
        .log_stream_arn_update = "LogStreamARNUpdate",
    };
};
