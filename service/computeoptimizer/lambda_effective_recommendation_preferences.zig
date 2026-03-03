const LambdaSavingsEstimationMode = @import("lambda_savings_estimation_mode.zig").LambdaSavingsEstimationMode;

/// Describes the effective recommendation preferences for Lambda functions.
pub const LambdaEffectiveRecommendationPreferences = struct {
    /// Describes the savings estimation mode applied for calculating savings
    /// opportunity for Lambda functions.
    savings_estimation_mode: ?LambdaSavingsEstimationMode = null,

    pub const json_field_names = .{
        .savings_estimation_mode = "savingsEstimationMode",
    };
};
