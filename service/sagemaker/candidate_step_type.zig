pub const CandidateStepType = enum {
    training,
    transform,
    processing,

    pub const json_field_names = .{
        .training = "TRAINING",
        .transform = "TRANSFORM",
        .processing = "PROCESSING",
    };
};
