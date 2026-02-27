pub const PluginBuildStatus = enum {
    ready,
    create_in_progress,
    create_failed,
    update_in_progress,
    update_failed,
    delete_in_progress,
    delete_failed,

    pub const json_field_names = .{
        .ready = "READY",
        .create_in_progress = "CREATE_IN_PROGRESS",
        .create_failed = "CREATE_FAILED",
        .update_in_progress = "UPDATE_IN_PROGRESS",
        .update_failed = "UPDATE_FAILED",
        .delete_in_progress = "DELETE_IN_PROGRESS",
        .delete_failed = "DELETE_FAILED",
    };
};
