const LookBackPeriodPreference = @import("look_back_period_preference.zig").LookBackPeriodPreference;
const EBSSavingsEstimationMode = @import("ebs_savings_estimation_mode.zig").EBSSavingsEstimationMode;

/// Describes the effective recommendation preferences for Amazon EBS volumes.
pub const EBSEffectiveRecommendationPreferences = struct {
    /// The number of days for which utilization metrics were analyzed for the
    /// volume.
    look_back_period: ?LookBackPeriodPreference = null,

    /// Describes the savings estimation mode preference applied for calculating
    /// savings opportunity for Amazon EBS volumes.
    savings_estimation_mode: ?EBSSavingsEstimationMode = null,

    pub const json_field_names = .{
        .look_back_period = "lookBackPeriod",
        .savings_estimation_mode = "savingsEstimationMode",
    };
};
