/// Provides a description of Amazon CloudWatch logging options, including the
/// log stream
/// Amazon Resource Name (ARN).
pub const CloudWatchLoggingOption = struct {
    /// The ARN of the CloudWatch log to receive application messages.
    log_stream_arn: []const u8,

    pub const json_field_names = .{
        .log_stream_arn = "LogStreamARN",
    };
};
