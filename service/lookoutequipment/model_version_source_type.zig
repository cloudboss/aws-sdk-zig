pub const ModelVersionSourceType = enum {
    training,
    retraining,
    import,

    pub const json_field_names = .{
        .training = "TRAINING",
        .retraining = "RETRAINING",
        .import = "IMPORT",
    };
};
