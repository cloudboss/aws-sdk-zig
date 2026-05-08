/// An evaluator to run against sessions
pub const Evaluator = struct {
    /// The unique identifier of the evaluator. Can reference built-in evaluators
    /// (e.g., `Builtin.Helpfulness`) or custom evaluators.
    evaluator_id: []const u8,

    pub const json_field_names = .{
        .evaluator_id = "evaluatorId",
    };
};
