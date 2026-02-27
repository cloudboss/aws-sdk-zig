pub const ModelPackageStatus = enum {
    pending,
    in_progress,
    completed,
    failed,
    deleting,

    pub const json_field_names = .{
        .pending = "PENDING",
        .in_progress = "IN_PROGRESS",
        .completed = "COMPLETED",
        .failed = "FAILED",
        .deleting = "DELETING",
    };
};
