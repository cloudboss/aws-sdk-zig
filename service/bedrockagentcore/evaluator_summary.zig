const EvaluatorStatistics = @import("evaluator_statistics.zig").EvaluatorStatistics;

/// Summary statistics for a single evaluator within a batch evaluation.
pub const EvaluatorSummary = struct {
    /// The unique identifier of the evaluator.
    evaluator_id: ?[]const u8 = null,

    /// The aggregated statistics for this evaluator.
    statistics: ?EvaluatorStatistics = null,

    /// The total number of sessions evaluated by this evaluator.
    total_evaluated: ?i32 = null,

    /// The total number of sessions that failed evaluation by this evaluator.
    total_failed: ?i32 = null,

    pub const json_field_names = .{
        .evaluator_id = "evaluatorId",
        .statistics = "statistics",
        .total_evaluated = "totalEvaluated",
        .total_failed = "totalFailed",
    };
};
