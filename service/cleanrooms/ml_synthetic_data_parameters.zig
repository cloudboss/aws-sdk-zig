const ColumnClassificationDetails = @import("column_classification_details.zig").ColumnClassificationDetails;

/// Parameters that control the generation of synthetic data for machine
/// learning, including privacy settings and column classification details.
pub const MLSyntheticDataParameters = struct {
    /// Classification details for data columns that specify how each column should
    /// be treated during synthetic data generation.
    column_classification: ColumnClassificationDetails,

    /// The epsilon value for differential privacy when generating synthetic data.
    /// Lower values provide stronger privacy guarantees but may reduce data
    /// utility.
    epsilon: f64,

    /// The maximum acceptable score for membership inference attack vulnerability.
    /// Synthetic data generation fails if the score for the resulting data exceeds
    /// this threshold.
    max_membership_inference_attack_score: f64,

    pub const json_field_names = .{
        .column_classification = "columnClassification",
        .epsilon = "epsilon",
        .max_membership_inference_attack_score = "maxMembershipInferenceAttackScore",
    };
};
