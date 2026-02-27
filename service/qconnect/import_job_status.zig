pub const ImportJobStatus = enum {
    start_in_progress,
    failed,
    complete,
    delete_in_progress,
    delete_failed,
    deleted,

    pub const json_field_names = .{
        .start_in_progress = "START_IN_PROGRESS",
        .failed = "FAILED",
        .complete = "COMPLETE",
        .delete_in_progress = "DELETE_IN_PROGRESS",
        .delete_failed = "DELETE_FAILED",
        .deleted = "DELETED",
    };
};
