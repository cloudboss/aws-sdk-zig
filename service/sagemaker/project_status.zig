pub const ProjectStatus = enum {
    pending,
    create_in_progress,
    create_completed,
    create_failed,
    delete_in_progress,
    delete_failed,
    delete_completed,
    update_in_progress,
    update_completed,
    update_failed,

    pub const json_field_names = .{
        .pending = "PENDING",
        .create_in_progress = "CREATE_IN_PROGRESS",
        .create_completed = "CREATE_COMPLETED",
        .create_failed = "CREATE_FAILED",
        .delete_in_progress = "DELETE_IN_PROGRESS",
        .delete_failed = "DELETE_FAILED",
        .delete_completed = "DELETE_COMPLETED",
        .update_in_progress = "UPDATE_IN_PROGRESS",
        .update_completed = "UPDATE_COMPLETED",
        .update_failed = "UPDATE_FAILED",
    };
};
