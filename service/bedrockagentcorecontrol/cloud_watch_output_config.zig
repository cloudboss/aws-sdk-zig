/// The configuration for writing evaluation results to CloudWatch logs with
/// embedded metric format (EMF) for monitoring.
pub const CloudWatchOutputConfig = struct {
    /// The name of the CloudWatch log group where evaluation results will be
    /// written. The log group will be created if it doesn't exist.
    log_group_name: []const u8,

    pub const json_field_names = .{
        .log_group_name = "logGroupName",
    };
};
