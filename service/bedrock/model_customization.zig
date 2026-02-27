pub const ModelCustomization = enum {
    fine_tuning,
    continued_pre_training,
    distillation,

    pub const json_field_names = .{
        .fine_tuning = "FINE_TUNING",
        .continued_pre_training = "CONTINUED_PRE_TRAINING",
        .distillation = "DISTILLATION",
    };
};
