pub const AnomalyDetectorStateValue = enum {
    pending_training,
    trained_insufficient_data,
    trained,

    pub const json_field_names = .{
        .pending_training = "PENDING_TRAINING",
        .trained_insufficient_data = "TRAINED_INSUFFICIENT_DATA",
        .trained = "TRAINED",
    };
};
