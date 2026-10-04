const ResultDestination = @import("result_destination.zig").ResultDestination;

/// The configuration for writing evaluation results to CloudWatch logs with
/// embedded metric format (EMF) for monitoring.
pub const CloudWatchOutputConfig = struct {
    /// The name of the CloudWatch log group where evaluation results will be
    /// written. An existing log group is used as-is; otherwise the service creates
    /// it, which requires the evaluation execution role to grant
    /// `logs:CreateLogGroup` on the log group. Don't specify this value when
    /// `resultDestination` is `SOURCE_LOG_GROUP`. The name can't be under the
    /// service-reserved `/aws/bedrock-agentcore/evaluations/` namespace, apart from
    /// this configuration's own service-managed default group.
    log_group_name: []const u8 = "",

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
        .metrics_namespace = "metricsNamespace",
        .result_destination = "resultDestination",
    };
};
