pub const StopAction = enum {
    start_evaluation,
    skip_evaluation,

    pub const json_field_names = .{
        .start_evaluation = "START_EVALUATION",
        .skip_evaluation = "SKIP_EVALUATION",
    };
};
