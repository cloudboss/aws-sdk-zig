pub const OrganizationResourceStatus = enum {
    create_successful,
    create_in_progress,
    create_failed,
    delete_successful,
    delete_failed,
    delete_in_progress,
    update_successful,
    update_in_progress,
    update_failed,

    pub const json_field_names = .{
        .create_successful = "CREATE_SUCCESSFUL",
        .create_in_progress = "CREATE_IN_PROGRESS",
        .create_failed = "CREATE_FAILED",
        .delete_successful = "DELETE_SUCCESSFUL",
        .delete_failed = "DELETE_FAILED",
        .delete_in_progress = "DELETE_IN_PROGRESS",
        .update_successful = "UPDATE_SUCCESSFUL",
        .update_in_progress = "UPDATE_IN_PROGRESS",
        .update_failed = "UPDATE_FAILED",
    };
};
