const CloudWatchLogDestination = @import("cloud_watch_log_destination.zig").CloudWatchLogDestination;
const LoggingFilter = @import("logging_filter.zig").LoggingFilter;

/// Defines a destination and its associated filtering criteria for query
/// logging.
pub const LoggingDestination = struct {
    /// Configuration details for logging to CloudWatch Logs.
    cloud_watch_logs: CloudWatchLogDestination,

    /// Filtering criteria that determine which queries are logged.
    filters: LoggingFilter,

    pub const json_field_names = .{
        .cloud_watch_logs = "cloudWatchLogs",
        .filters = "filters",
    };
};
