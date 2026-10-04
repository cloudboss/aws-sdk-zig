/// Configuration for using a batch evaluation as the source of agent traces for
/// recommendations.
pub const BatchEvaluationTraceConfig = struct {
    /// The ARN of the completed batch evaluation to use as the trace source.
    batch_evaluation_arn: []const u8,

    pub const json_field_names = .{
        .batch_evaluation_arn = "batchEvaluationArn",
    };
};
