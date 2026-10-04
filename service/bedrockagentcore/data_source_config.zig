const CloudWatchLogsSource = @import("cloud_watch_logs_source.zig").CloudWatchLogsSource;
const OnlineEvaluationConfigSource = @import("online_evaluation_config_source.zig").OnlineEvaluationConfigSource;

/// Configuration for the data source used in evaluation.
pub const DataSourceConfig = union(enum) {
    /// Configuration for pulling agent session traces from CloudWatch Logs.
    cloud_watch_logs: ?CloudWatchLogsSource,
    /// Reference an existing OnlineEvaluationConfig as session source
    online_evaluation_config_source: ?OnlineEvaluationConfigSource,

    pub const json_field_names = .{
        .cloud_watch_logs = "cloudWatchLogs",
        .online_evaluation_config_source = "onlineEvaluationConfigSource",
    };
};
