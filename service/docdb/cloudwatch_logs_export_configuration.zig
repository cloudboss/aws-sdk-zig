/// The configuration setting for the log types to be enabled for export to
/// Amazon
/// CloudWatch Logs for a specific instance or cluster.
///
/// The `EnableLogTypes` and `DisableLogTypes` arrays determine
/// which logs are exported (or not exported) to CloudWatch Logs. The values
/// within these
/// arrays depend on the engine that is being used.
pub const CloudwatchLogsExportConfiguration = struct {
    /// The list of log types to disable.
    disable_log_types: ?[]const []const u8,

    /// The list of log types to enable.
    enable_log_types: ?[]const []const u8,
};
