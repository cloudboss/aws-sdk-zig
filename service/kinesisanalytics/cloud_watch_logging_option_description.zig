/// Description of the CloudWatch logging option.
pub const CloudWatchLoggingOptionDescription = struct {
    /// ID of the CloudWatch logging option description.
    cloud_watch_logging_option_id: ?[]const u8 = null,

    /// ARN of the CloudWatch log to receive application messages.
    log_stream_arn: []const u8,

    /// IAM ARN of the role to use to send application messages. Note: To write
    /// application messages to CloudWatch, the IAM role used must have the
    /// `PutLogEvents` policy action enabled.
    role_arn: []const u8,

    pub const json_field_names = .{
        .cloud_watch_logging_option_id = "CloudWatchLoggingOptionId",
        .log_stream_arn = "LogStreamARN",
        .role_arn = "RoleARN",
    };
};
