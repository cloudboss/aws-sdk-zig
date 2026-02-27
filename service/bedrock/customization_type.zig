pub const CustomizationType = enum {
    fine_tuning,
    continued_pre_training,
    distillation,
    reinforcement_fine_tuning,
    imported,

    pub const json_field_names = .{
        .fine_tuning = "FINE_TUNING",
        .continued_pre_training = "CONTINUED_PRE_TRAINING",
        .distillation = "DISTILLATION",
        .reinforcement_fine_tuning = "REINFORCEMENT_FINE_TUNING",
        .imported = "IMPORTED",
    };
};
