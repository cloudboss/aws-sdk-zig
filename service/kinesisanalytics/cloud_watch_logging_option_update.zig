/// Describes CloudWatch logging option updates.
pub const CloudWatchLoggingOptionUpdate = struct {
    /// ID of the CloudWatch logging option to update
    cloud_watch_logging_option_id: []const u8,

    /// ARN of the CloudWatch log to receive application messages.
    log_stream_arn_update: ?[]const u8 = null,

    /// IAM ARN of the role to use to send application messages. Note: To write
    /// application messages to CloudWatch, the IAM role used must have the
    /// `PutLogEvents` policy action enabled.
    role_arn_update: ?[]const u8 = null,

    pub const json_field_names = .{
        .cloud_watch_logging_option_id = "CloudWatchLoggingOptionId",
        .log_stream_arn_update = "LogStreamARNUpdate",
        .role_arn_update = "RoleARNUpdate",
    };
};
