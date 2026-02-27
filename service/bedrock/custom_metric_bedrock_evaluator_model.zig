/// Defines the model you want to evaluate custom metrics in an Amazon Bedrock
/// evaluation job.
pub const CustomMetricBedrockEvaluatorModel = struct {
    /// The Amazon Resource Name (ARN) of the evaluator model for custom metrics.
    /// For a list of supported evaluator models, see [Evaluate model performance
    /// using another LLM as a
    /// judge](https://docs.aws.amazon.com/bedrock/latest/userguide/evaluation-judge.html) and [Evaluate the performance of RAG sources using Amazon Bedrock evaluations](https://docs.aws.amazon.com/bedrock/latest/userguide/evaluation-kb.html).
    model_identifier: []const u8,

    pub const json_field_names = .{
        .model_identifier = "modelIdentifier",
    };
};
