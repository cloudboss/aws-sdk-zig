pub const TrainedModelInferenceJobStatus = enum {
    create_pending,
    create_in_progress,
    create_failed,
    active,
    cancel_pending,
    cancel_in_progress,
    cancel_failed,
    inactive,

    pub const json_field_names = .{
        .create_pending = "CREATE_PENDING",
        .create_in_progress = "CREATE_IN_PROGRESS",
        .create_failed = "CREATE_FAILED",
        .active = "ACTIVE",
        .cancel_pending = "CANCEL_PENDING",
        .cancel_in_progress = "CANCEL_IN_PROGRESS",
        .cancel_failed = "CANCEL_FAILED",
        .inactive = "INACTIVE",
    };
};
