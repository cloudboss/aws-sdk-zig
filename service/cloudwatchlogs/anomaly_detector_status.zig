pub const AnomalyDetectorStatus = enum {
    initializing,
    training,
    analyzing,
    failed,
    deleted,
    paused,

    pub const json_field_names = .{
        .initializing = "INITIALIZING",
        .training = "TRAINING",
        .analyzing = "ANALYZING",
        .failed = "FAILED",
        .deleted = "DELETED",
        .paused = "PAUSED",
    };
};
