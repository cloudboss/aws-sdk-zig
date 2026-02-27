pub const LineageImportStatus = enum {
    in_progress,
    success,
    failed,
    partially_succeeded,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .success = "SUCCESS",
        .failed = "FAILED",
        .partially_succeeded = "PARTIALLY_SUCCEEDED",
    };
};
