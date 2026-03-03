/// Options for CloudWatch Logs as a logging destination.
pub const VerifiedAccessLogCloudWatchLogsDestinationOptions = struct {
    /// Indicates whether logging is enabled.
    enabled: bool,

    /// The ID of the CloudWatch Logs log group.
    log_group: ?[]const u8 = null,
};
