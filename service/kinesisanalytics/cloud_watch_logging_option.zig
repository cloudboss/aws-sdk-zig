/// Provides a description of CloudWatch logging options, including the log
/// stream
/// Amazon Resource Name (ARN) and the role ARN.
pub const CloudWatchLoggingOption = struct {
    /// ARN of the CloudWatch log to receive application messages.
    log_stream_arn: []const u8,

    /// IAM ARN of the role to use to send application messages. Note: To write
    /// application
    /// messages to CloudWatch, the IAM role that is used must have the
    /// `PutLogEvents` policy action enabled.
    role_arn: []const u8,

    pub const json_field_names = .{
        .log_stream_arn = "LogStreamARN",
        .role_arn = "RoleARN",
    };
};
