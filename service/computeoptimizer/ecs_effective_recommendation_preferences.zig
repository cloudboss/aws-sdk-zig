const ECSSavingsEstimationMode = @import("ecs_savings_estimation_mode.zig").ECSSavingsEstimationMode;

/// Describes the effective recommendation preferences for Amazon ECS services.
pub const ECSEffectiveRecommendationPreferences = struct {
    /// Describes the savings estimation mode preference applied for calculating
    /// savings opportunity for Amazon ECS services.
    savings_estimation_mode: ?ECSSavingsEstimationMode = null,

    pub const json_field_names = .{
        .savings_estimation_mode = "savingsEstimationMode",
    };
};
