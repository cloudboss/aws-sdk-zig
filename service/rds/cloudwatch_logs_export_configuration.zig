/// The configuration setting for the log types to be enabled for export to
/// CloudWatch Logs for a specific DB instance or DB cluster.
///
/// The `EnableLogTypes` and `DisableLogTypes` arrays determine which logs will
/// be exported (or not exported) to CloudWatch Logs. The values within these
/// arrays depend on the DB engine being used.
///
/// For more information about exporting CloudWatch Logs for Amazon RDS DB
/// instances, see [Publishing Database Logs to Amazon CloudWatch Logs
/// ](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_LogAccess.html#USER_LogAccess.Procedural.UploadtoCloudWatch) in the *Amazon RDS User Guide*.
///
/// For more information about exporting CloudWatch Logs for Amazon Aurora DB
/// clusters, see [Publishing Database Logs to Amazon CloudWatch
/// Logs](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/USER_LogAccess.html#USER_LogAccess.Procedural.UploadtoCloudWatch) in the *Amazon Aurora User Guide*.
pub const CloudwatchLogsExportConfiguration = struct {
    /// The list of log types to disable.
    ///
    /// The following values are valid for each DB engine:
    ///
    /// * Aurora MySQL - `audit | error | general | slowquery`
    /// * Aurora PostgreSQL - `postgresql`
    /// * RDS for MySQL - `error | general | slowquery`
    /// * RDS for PostgreSQL - `postgresql | upgrade`
    disable_log_types: ?[]const []const u8,

    /// The list of log types to enable.
    ///
    /// The following values are valid for each DB engine:
    ///
    /// * Aurora MySQL - `audit | error | general | slowquery`
    /// * Aurora PostgreSQL - `postgresql`
    /// * RDS for MySQL - `error | general | slowquery`
    /// * RDS for PostgreSQL - `postgresql | upgrade`
    enable_log_types: ?[]const []const u8,
};
