pub const TrainedModelStatus = enum {
    create_pending,
    create_in_progress,
    create_failed,
    active,
    delete_pending,
    delete_in_progress,
    delete_failed,
    inactive,
    cancel_pending,
    cancel_in_progress,
    cancel_failed,

    pub const json_field_names = .{
        .create_pending = "CREATE_PENDING",
        .create_in_progress = "CREATE_IN_PROGRESS",
        .create_failed = "CREATE_FAILED",
        .active = "ACTIVE",
        .delete_pending = "DELETE_PENDING",
        .delete_in_progress = "DELETE_IN_PROGRESS",
        .delete_failed = "DELETE_FAILED",
        .inactive = "INACTIVE",
        .cancel_pending = "CANCEL_PENDING",
        .cancel_in_progress = "CANCEL_IN_PROGRESS",
        .cancel_failed = "CANCEL_FAILED",
    };
};
