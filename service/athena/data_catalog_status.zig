pub const DataCatalogStatus = enum {
    create_in_progress,
    create_complete,
    create_failed,
    create_failed_cleanup_in_progress,
    create_failed_cleanup_complete,
    create_failed_cleanup_failed,
    delete_in_progress,
    delete_complete,
    delete_failed,

    pub const json_field_names = .{
        .create_in_progress = "CREATE_IN_PROGRESS",
        .create_complete = "CREATE_COMPLETE",
        .create_failed = "CREATE_FAILED",
        .create_failed_cleanup_in_progress = "CREATE_FAILED_CLEANUP_IN_PROGRESS",
        .create_failed_cleanup_complete = "CREATE_FAILED_CLEANUP_COMPLETE",
        .create_failed_cleanup_failed = "CREATE_FAILED_CLEANUP_FAILED",
        .delete_in_progress = "DELETE_IN_PROGRESS",
        .delete_complete = "DELETE_COMPLETE",
        .delete_failed = "DELETE_FAILED",
    };
};
