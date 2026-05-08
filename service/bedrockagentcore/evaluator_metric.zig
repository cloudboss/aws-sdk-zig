const ControlStats = @import("control_stats.zig").ControlStats;
const VariantResult = @import("variant_result.zig").VariantResult;

/// Statistical metrics for a single evaluator comparing control and treatment
/// variants.
pub const EvaluatorMetric = struct {
    /// The statistics for the control variant.
    control_stats: ControlStats,

    /// The Amazon Resource Name (ARN) of the evaluator.
    evaluator_arn: []const u8,

    /// The results for each treatment variant compared against the control.
    variant_results: []const VariantResult,

    pub const json_field_names = .{
        .control_stats = "controlStats",
        .evaluator_arn = "evaluatorArn",
        .variant_results = "variantResults",
    };
};
