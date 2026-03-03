/// The configuration setting for the log types to be enabled for export
/// to CloudWatch Logs for a specific DB instance or DB cluster.
///
/// The `EnableLogTypes` and `DisableLogTypes` arrays
/// determine which logs will be exported (or not exported) to CloudWatch Logs.
///
/// Valid log types are: `audit` (to publish audit logs) and
/// `slowquery` (to publish slow-query logs). See [Publishing Neptune logs
/// to Amazon CloudWatch
/// logs](https://docs.aws.amazon.com/neptune/latest/userguide/cloudwatch-logs.html).
pub const CloudwatchLogsExportConfiguration = struct {
    /// The list of log types to disable.
    disable_log_types: ?[]const []const u8 = null,

    /// The list of log types to enable.
    enable_log_types: ?[]const []const u8 = null,
};
