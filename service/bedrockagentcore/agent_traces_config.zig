const CloudWatchLogsTraceConfig = @import("cloud_watch_logs_trace_config.zig").CloudWatchLogsTraceConfig;

/// The configuration specifying where to read agent traces from for
/// recommendation analysis.
pub const AgentTracesConfig = union(enum) {
    /// Agent traces read from CloudWatch Logs.
    cloudwatch_logs: ?CloudWatchLogsTraceConfig,
    /// Agent traces provided as inline session spans in OpenTelemetry format.
    session_spans: ?[]const []const u8,

    pub const json_field_names = .{
        .cloudwatch_logs = "cloudwatchLogs",
        .session_spans = "sessionSpans",
    };
};
