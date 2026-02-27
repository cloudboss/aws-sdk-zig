/// A list of the log types whose configuration is still pending. In other
/// words, these log types are in the process of being activated or deactivated.
///
/// Valid log types are: `audit` (to publish audit logs) and
/// `slowquery` (to publish slow-query logs). See [Publishing Neptune logs
/// to Amazon CloudWatch
/// logs](https://docs.aws.amazon.com/neptune/latest/userguide/cloudwatch-logs.html).
pub const PendingCloudwatchLogsExports = struct {
    /// Log types that are in the process of being enabled. After they are
    /// enabled, these log types are exported to CloudWatch Logs.
    log_types_to_disable: ?[]const []const u8,

    /// Log types that are in the process of being deactivated. After they are
    /// deactivated, these log types aren't exported to CloudWatch Logs.
    log_types_to_enable: ?[]const []const u8,
};
