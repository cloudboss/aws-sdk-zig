pub const ServiceStatus = enum {
    create_failed,
    running,
    deleted,
    delete_failed,
    paused,
    operation_in_progress,

    pub const json_field_names = .{
        .create_failed = "CREATE_FAILED",
        .running = "RUNNING",
        .deleted = "DELETED",
        .delete_failed = "DELETE_FAILED",
        .paused = "PAUSED",
        .operation_in_progress = "OPERATION_IN_PROGRESS",
    };
};
