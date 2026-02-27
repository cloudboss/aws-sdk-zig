/// The evaluator model used in knowledge base evaluation job or in model
/// evaluation job that use a model as judge. This model computes all evaluation
/// related metrics.
pub const BedrockEvaluatorModel = struct {
    /// The Amazon Resource Name (ARN) of the evaluator model used used in knowledge
    /// base evaluation job or in model evaluation job that use a model as judge.
    model_identifier: []const u8,

    pub const json_field_names = .{
        .model_identifier = "modelIdentifier",
    };
};
