pub const AutoMLMode = enum {
    auto,
    ensembling,
    hyperparameter_tuning,

    pub const json_field_names = .{
        .auto = "AUTO",
        .ensembling = "ENSEMBLING",
        .hyperparameter_tuning = "HYPERPARAMETER_TUNING",
    };
};
