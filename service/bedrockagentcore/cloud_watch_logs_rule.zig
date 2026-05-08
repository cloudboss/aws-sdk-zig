const CloudWatchLogsFilter = @import("cloud_watch_logs_filter.zig").CloudWatchLogsFilter;

/// A rule configuration for filtering agent traces from CloudWatch Logs.
pub const CloudWatchLogsRule = struct {
    /// The list of filters to apply when reading agent traces.
    filters: ?[]const CloudWatchLogsFilter = null,

    pub const json_field_names = .{
        .filters = "filters",
    };
};
