/// A reference to an evaluator used for recommendation assessment.
pub const RecommendationEvaluatorReference = struct {
    /// The Amazon Resource Name (ARN) of the evaluator.
    evaluator_arn: []const u8,

    pub const json_field_names = .{
        .evaluator_arn = "evaluatorArn",
    };
};
