/// The settings for delivering connector logs to Amazon CloudWatch Logs.
pub const CloudWatchLogsLogDelivery = struct {
    /// Whether log delivery to Amazon CloudWatch Logs is enabled.
    enabled: bool = false,

    /// The name of the CloudWatch log group that is the destination for log
    /// delivery.
    log_group: ?[]const u8,

    pub const json_field_names = .{
        .enabled = "enabled",
        .log_group = "logGroup",
    };
};
