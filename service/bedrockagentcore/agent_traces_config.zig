const BatchEvaluationTraceConfig = @import("batch_evaluation_trace_config.zig").BatchEvaluationTraceConfig;
const CloudWatchLogsTraceConfig = @import("cloud_watch_logs_trace_config.zig").CloudWatchLogsTraceConfig;
const OnlineEvaluationTraceConfig = @import("online_evaluation_trace_config.zig").OnlineEvaluationTraceConfig;

/// The configuration specifying where to read agent traces from for
/// recommendation analysis.
pub const AgentTracesConfig = union(enum) {
    /// Use a completed batch evaluation as the source of agent traces.
    batch_evaluation: ?BatchEvaluationTraceConfig,
    /// Agent traces read from CloudWatch Logs.
    cloudwatch_logs: ?CloudWatchLogsTraceConfig,
    /// Agent traces from an online evaluation configuration over a specified time
    /// range.
    online_evaluation: ?OnlineEvaluationTraceConfig,
    /// Agent traces provided as inline session spans in OpenTelemetry format.
    session_spans: ?[]const []const u8,

    pub const json_field_names = .{
        .batch_evaluation = "batchEvaluation",
        .cloudwatch_logs = "cloudwatchLogs",
        .online_evaluation = "onlineEvaluation",
        .session_spans = "sessionSpans",
    };
};
