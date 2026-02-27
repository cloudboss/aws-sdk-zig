pub const ModelVersionStatus = enum {
    in_progress,
    success,
    failed,
    import_in_progress,
    canceled,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .success = "SUCCESS",
        .failed = "FAILED",
        .import_in_progress = "IMPORT_IN_PROGRESS",
        .canceled = "CANCELED",
    };
};
