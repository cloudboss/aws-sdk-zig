const EBSSavingsEstimationMode = @import("ebs_savings_estimation_mode.zig").EBSSavingsEstimationMode;

/// Describes the effective recommendation preferences for Amazon EBS volumes.
pub const EBSEffectiveRecommendationPreferences = struct {
    /// Describes the savings estimation mode preference applied for calculating
    /// savings opportunity for Amazon EBS volumes.
    savings_estimation_mode: ?EBSSavingsEstimationMode = null,

    pub const json_field_names = .{
        .savings_estimation_mode = "savingsEstimationMode",
    };
};
