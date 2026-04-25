/// Details about delivering logs to CloudWatch Logs.
pub const ReplicatorCloudWatchLogs = struct {
    /// Whether log delivery to CloudWatch Logs is enabled.
    enabled: bool,

    /// The CloudWatch log group that is the destination for log delivery.
    log_group: ?[]const u8 = null,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .log_group = "LogGroup",
    };
};
