pub const AutoSnapshotStatus = enum {
    success,
    failed,
    in_progress,
    not_found,

    pub const json_field_names = .{
        .success = "SUCCESS",
        .failed = "FAILED",
        .in_progress = "IN_PROGRESS",
        .not_found = "NOT_FOUND",
    };
};
