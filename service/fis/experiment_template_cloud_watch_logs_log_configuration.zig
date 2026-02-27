/// Describes the configuration for experiment logging to Amazon CloudWatch
/// Logs.
pub const ExperimentTemplateCloudWatchLogsLogConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the destination Amazon CloudWatch Logs log
    /// group.
    log_group_arn: ?[]const u8,

    pub const json_field_names = .{
        .log_group_arn = "logGroupArn",
    };
};
