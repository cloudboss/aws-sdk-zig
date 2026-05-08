const CloudWatchLogsRule = @import("cloud_watch_logs_rule.zig").CloudWatchLogsRule;

/// Configuration for reading agent traces from CloudWatch Logs for
/// recommendation analysis.
pub const CloudWatchLogsTraceConfig = struct {
    /// The end time of the time range to read traces from.
    end_time: i64,

    /// The list of CloudWatch log group ARNs to read agent traces from.
    log_group_arns: []const []const u8,

    /// Optional rule configuration for filtering traces.
    rule: ?CloudWatchLogsRule = null,

    /// The list of service names to filter traces within the specified log groups.
    service_names: []const []const u8,

    /// The start time of the time range to read traces from.
    start_time: i64,

    pub const json_field_names = .{
        .end_time = "endTime",
        .log_group_arns = "logGroupArns",
        .rule = "rule",
        .service_names = "serviceNames",
        .start_time = "startTime",
    };
};
