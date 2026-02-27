const DataPrivacyScores = @import("data_privacy_scores.zig").DataPrivacyScores;

/// Comprehensive evaluation metrics for synthetic data that assess both the
/// utility of the generated data for machine learning tasks and its privacy
/// preservation characteristics.
pub const SyntheticDataEvaluationScores = struct {
    /// Privacy-specific evaluation scores that measure how well the synthetic data
    /// protects individual privacy, including assessments of potential privacy
    /// risks such as membership inference attacks.
    data_privacy_scores: DataPrivacyScores,

    pub const json_field_names = .{
        .data_privacy_scores = "dataPrivacyScores",
    };
};
