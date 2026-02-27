pub const ServiceStatus = enum {
    /// Service is active.
    active,
    /// Service creation in progress.
    create_in_progress,
    /// Service deletion in progress
    delete_in_progress,
    /// Service creation failed
    create_failed,
    /// Service deletion failed.
    delete_failed,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .create_in_progress = "CREATE_IN_PROGRESS",
        .delete_in_progress = "DELETE_IN_PROGRESS",
        .create_failed = "CREATE_FAILED",
        .delete_failed = "DELETE_FAILED",
    };
};
