pub const ServerlessJobType = enum {
    fine_tuning,
    evaluation,

    pub const json_field_names = .{
        .fine_tuning = "FINE_TUNING",
        .evaluation = "EVALUATION",
    };
};
