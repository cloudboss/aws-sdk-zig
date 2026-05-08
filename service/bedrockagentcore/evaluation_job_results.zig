const EvaluatorSummary = @import("evaluator_summary.zig").EvaluatorSummary;

/// Aggregated results from a batch evaluation, including session completion
/// counts and evaluator score summaries.
pub const EvaluationJobResults = struct {
    /// A list of per-evaluator summary statistics.
    evaluator_summaries: ?[]const EvaluatorSummary = null,

    /// The number of sessions that have been successfully evaluated.
    number_of_sessions_completed: ?i32 = null,

    /// The number of sessions that failed evaluation.
    number_of_sessions_failed: ?i32 = null,

    /// The number of sessions that were ignored during evaluation.
    number_of_sessions_ignored: ?i32 = null,

    /// The number of sessions currently being evaluated.
    number_of_sessions_in_progress: ?i32 = null,

    /// The total number of sessions included in the batch evaluation.
    total_number_of_sessions: ?i32 = null,

    pub const json_field_names = .{
        .evaluator_summaries = "evaluatorSummaries",
        .number_of_sessions_completed = "numberOfSessionsCompleted",
        .number_of_sessions_failed = "numberOfSessionsFailed",
        .number_of_sessions_ignored = "numberOfSessionsIgnored",
        .number_of_sessions_in_progress = "numberOfSessionsInProgress",
        .total_number_of_sessions = "totalNumberOfSessions",
    };
};
