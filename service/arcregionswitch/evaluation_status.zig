pub const EvaluationStatus = enum {
    passed,
    action_required,
    pending_evaluation,
    unknown,

    pub const json_field_names = .{
        .passed = "PASSED",
        .action_required = "ACTION_REQUIRED",
        .pending_evaluation = "PENDING_EVALUATION",
        .unknown = "UNKNOWN",
    };
};
