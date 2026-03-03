/// Describes an action that sends data to CloudWatch Logs.
pub const CloudwatchLogsAction = struct {
    /// Indicates whether batches of log records will be extracted and uploaded into
    /// CloudWatch. Values include `true` or `false`
    /// *(default)*.
    batch_mode: ?bool = null,

    /// The CloudWatch log group to which the action sends data.
    log_group_name: []const u8,

    /// The IAM role that allows access to the CloudWatch log.
    role_arn: []const u8,

    pub const json_field_names = .{
        .batch_mode = "batchMode",
        .log_group_name = "logGroupName",
        .role_arn = "roleArn",
    };
};
