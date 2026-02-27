/// The Amazon CloudWatch Logs logging configuration settings for the pipe.
pub const CloudwatchLogsLogDestination = struct {
    /// The Amazon Web Services Resource Name (ARN) for the CloudWatch log group to
    /// which EventBridge sends the log records.
    log_group_arn: ?[]const u8,

    pub const json_field_names = .{
        .log_group_arn = "LogGroupArn",
    };
};
