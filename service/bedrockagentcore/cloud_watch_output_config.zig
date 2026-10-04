const ResultDestination = @import("result_destination.zig").ResultDestination;

/// CloudWatch Logs destination for batch evaluation results.
pub const CloudWatchOutputConfig = struct {
    /// The name of the CloudWatch log group where evaluation results will be
    /// written. This value doesn't apply when `resultDestination` is
    /// `SOURCE_LOG_GROUP`, because results are written back to the trace source log
    /// group. The name can't be under the service-reserved
    /// `/aws/bedrock-agentcore/evaluations/` namespace, apart from the
    /// service-managed default group.
    log_group_name: []const u8 = "",

    /// The name of the CloudWatch log stream where evaluation results will be
    /// written.
    log_stream_name: []const u8 = "",

    /// The CloudWatch metrics namespace where evaluation result metrics are
    /// published. If you omit this value, the service publishes metrics to
    /// `Bedrock-AgentCore/Evaluations`. This value can't begin with `AWS/`.
    metrics_namespace: ?[]const u8 = null,

    /// The destination where evaluation results are written. Valid values:
    ///
    /// * `DEDICATED_LOG_GROUP` (default) – Writes results to a dedicated result log
    ///   group.
    /// * `SOURCE_LOG_GROUP` – Writes results back to the log group that the agent
    ///   traces were read from. If you use this value, don't specify
    ///   `logGroupName`.
    result_destination: ResultDestination = .dedicated_log_group,

    pub const json_field_names = .{
        .log_group_name = "logGroupName",
        .log_stream_name = "logStreamName",
        .metrics_namespace = "metricsNamespace",
        .result_destination = "resultDestination",
    };
};
