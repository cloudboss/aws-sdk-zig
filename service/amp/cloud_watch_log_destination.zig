/// Configuration details for logging to CloudWatch Logs.
pub const CloudWatchLogDestination = struct {
    /// The ARN of the CloudWatch log group to which the vended log data will be
    /// published. This log group must exist prior to calling this operation.
    log_group_arn: []const u8,

    pub const json_field_names = .{
        .log_group_arn = "logGroupArn",
    };
};
