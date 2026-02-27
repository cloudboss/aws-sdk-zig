/// The configuration details of the CloudWatch Logs destination.
pub const CloudWatchLogsDestinationDetails = struct {
    /// The name of the CloudWatch Logs log group.
    log_group: ?[]const u8,
};
