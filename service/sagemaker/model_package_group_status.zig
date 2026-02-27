pub const ModelPackageGroupStatus = enum {
    pending,
    in_progress,
    completed,
    failed,
    deleting,
    delete_failed,

    pub const json_field_names = .{
        .pending = "PENDING",
        .in_progress = "IN_PROGRESS",
        .completed = "COMPLETED",
        .failed = "FAILED",
        .deleting = "DELETING",
        .delete_failed = "DELETE_FAILED",
    };
};
