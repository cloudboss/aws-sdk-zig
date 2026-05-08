const CloudWatchLogsSource = @import("cloud_watch_logs_source.zig").CloudWatchLogsSource;

/// Where to pull session spans from
pub const DataSourceConfig = union(enum) {
    /// Pull session spans from CloudWatch
    cloud_watch_logs: ?CloudWatchLogsSource,

    pub const json_field_names = .{
        .cloud_watch_logs = "cloudWatchLogs",
    };
};
