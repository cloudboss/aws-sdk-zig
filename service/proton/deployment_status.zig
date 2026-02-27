pub const DeploymentStatus = enum {
    in_progress,
    failed,
    succeeded,
    delete_in_progress,
    delete_failed,
    delete_complete,
    cancelling,
    cancelled,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .failed = "FAILED",
        .succeeded = "SUCCEEDED",
        .delete_in_progress = "DELETE_IN_PROGRESS",
        .delete_failed = "DELETE_FAILED",
        .delete_complete = "DELETE_COMPLETE",
        .cancelling = "CANCELLING",
        .cancelled = "CANCELLED",
    };
};
