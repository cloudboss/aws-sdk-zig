const LambdaSavingsEstimationModeSource = @import("lambda_savings_estimation_mode_source.zig").LambdaSavingsEstimationModeSource;

/// Describes the savings estimation used for calculating savings opportunity
/// for Lambda functions.
pub const LambdaSavingsEstimationMode = struct {
    /// Describes the source for calculation of savings opportunity for Lambda
    /// functions.
    source: ?LambdaSavingsEstimationModeSource = null,

    pub const json_field_names = .{
        .source = "source",
    };
};
