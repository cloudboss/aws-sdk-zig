const PredictionExplanations = @import("prediction_explanations.zig").PredictionExplanations;

/// The model version evalutions.
pub const ModelVersionEvaluation = struct {
    /// The evaluation score generated for the model version.
    evaluation_score: ?[]const u8,

    /// The output variable name.
    output_variable_name: ?[]const u8,

    /// The prediction explanations generated for the model version.
    prediction_explanations: ?PredictionExplanations,

    pub const json_field_names = .{
        .evaluation_score = "evaluationScore",
        .output_variable_name = "outputVariableName",
        .prediction_explanations = "predictionExplanations",
    };
};
