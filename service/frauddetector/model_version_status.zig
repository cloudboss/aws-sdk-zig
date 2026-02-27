pub const ModelVersionStatus = enum {
    active,
    inactive,
    training_cancelled,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .inactive = "INACTIVE",
        .training_cancelled = "TRAINING_CANCELLED",
    };
};
