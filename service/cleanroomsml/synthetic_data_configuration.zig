const SyntheticDataEvaluationScores = @import("synthetic_data_evaluation_scores.zig").SyntheticDataEvaluationScores;
const MLSyntheticDataParameters = @import("ml_synthetic_data_parameters.zig").MLSyntheticDataParameters;

/// Configuration settings for synthetic data generation, including the
/// parameters that control data synthesis and the evaluation scores that
/// measure the quality and privacy characteristics of the generated synthetic
/// data.
pub const SyntheticDataConfiguration = struct {
    /// Evaluation scores that assess the quality and privacy characteristics of the
    /// generated synthetic data, providing metrics on data utility and privacy
    /// preservation.
    synthetic_data_evaluation_scores: ?SyntheticDataEvaluationScores = null,

    /// The parameters that control how synthetic data is generated, including
    /// privacy settings, column classifications, and other configuration options
    /// that affect the data synthesis process.
    synthetic_data_parameters: MLSyntheticDataParameters,

    pub const json_field_names = .{
        .synthetic_data_evaluation_scores = "syntheticDataEvaluationScores",
        .synthetic_data_parameters = "syntheticDataParameters",
    };
};
