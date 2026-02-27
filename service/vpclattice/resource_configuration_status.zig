pub const ResourceConfigurationStatus = enum {
    /// Resource Configuration is active.
    active,
    /// Resource Configuration creation in progress.
    create_in_progress,
    /// Resource Configuration update in progress.
    update_in_progress,
    /// Resource Configuration deletion in progress
    delete_in_progress,
    /// Resource Configuration creation failed
    create_failed,
    /// Resource Configuration update failed
    update_failed,
    /// Resource Configuration deletion failed.
    delete_failed,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .create_in_progress = "CREATE_IN_PROGRESS",
        .update_in_progress = "UPDATE_IN_PROGRESS",
        .delete_in_progress = "DELETE_IN_PROGRESS",
        .create_failed = "CREATE_FAILED",
        .update_failed = "UPDATE_FAILED",
        .delete_failed = "DELETE_FAILED",
    };
};
