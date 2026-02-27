pub const ImportFileTaskStatus = enum {
    import_in_progress,
    import_failed,
    import_partial_success,
    import_success,
    delete_in_progress,
    delete_failed,
    delete_partial_success,
    delete_success,

    pub const json_field_names = .{
        .import_in_progress = "IMPORT_IN_PROGRESS",
        .import_failed = "IMPORT_FAILED",
        .import_partial_success = "IMPORT_PARTIAL_SUCCESS",
        .import_success = "IMPORT_SUCCESS",
        .delete_in_progress = "DELETE_IN_PROGRESS",
        .delete_failed = "DELETE_FAILED",
        .delete_partial_success = "DELETE_PARTIAL_SUCCESS",
        .delete_success = "DELETE_SUCCESS",
    };
};
