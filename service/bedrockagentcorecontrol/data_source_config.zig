const CloudWatchLogsInputConfig = @import("cloud_watch_logs_input_config.zig").CloudWatchLogsInputConfig;

/// The configuration that specifies where to read agent traces for online
/// evaluation.
pub const DataSourceConfig = union(enum) {
    /// The CloudWatch logs configuration for reading agent traces from log groups.
    cloud_watch_logs: ?CloudWatchLogsInputConfig,

    pub const json_field_names = .{
        .cloud_watch_logs = "cloudWatchLogs",
    };
};
