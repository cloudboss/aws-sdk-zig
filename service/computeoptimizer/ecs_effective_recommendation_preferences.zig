const LookBackPeriodPreference = @import("look_back_period_preference.zig").LookBackPeriodPreference;
const ECSSavingsEstimationMode = @import("ecs_savings_estimation_mode.zig").ECSSavingsEstimationMode;

/// Describes the effective recommendation preferences for Amazon ECS services.
pub const ECSEffectiveRecommendationPreferences = struct {
    /// The number of days the Amazon ECS service utilization metrics were analyzed.
    look_back_period: ?LookBackPeriodPreference = null,

    /// Describes the savings estimation mode preference applied for calculating
    /// savings opportunity for Amazon ECS services.
    savings_estimation_mode: ?ECSSavingsEstimationMode = null,

    pub const json_field_names = .{
        .look_back_period = "lookBackPeriod",
        .savings_estimation_mode = "savingsEstimationMode",
    };
};
