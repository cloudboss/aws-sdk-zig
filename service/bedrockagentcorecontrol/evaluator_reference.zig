/// The reference to an evaluator used in online evaluation configurations,
/// containing the evaluator identifier.
pub const EvaluatorReference = union(enum) {
    /// The unique identifier of the evaluator. Can reference builtin evaluators
    /// (e.g., Builtin.Helpfulness) or custom evaluators.
    evaluator_id: ?[]const u8,

    pub const json_field_names = .{
        .evaluator_id = "evaluatorId",
    };
};
