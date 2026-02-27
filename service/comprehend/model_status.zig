pub const ModelStatus = enum {
    submitted,
    training,
    deleting,
    stop_requested,
    stopped,
    in_error,
    trained,
    trained_with_warning,

    pub const json_field_names = .{
        .submitted = "SUBMITTED",
        .training = "TRAINING",
        .deleting = "DELETING",
        .stop_requested = "STOP_REQUESTED",
        .stopped = "STOPPED",
        .in_error = "IN_ERROR",
        .trained = "TRAINED",
        .trained_with_warning = "TRAINED_WITH_WARNING",
    };
};
