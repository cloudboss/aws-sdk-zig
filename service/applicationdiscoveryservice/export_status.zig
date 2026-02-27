pub const ExportStatus = enum {
    failed,
    succeeded,
    in_progress,

    pub const json_field_names = .{
        .failed = "FAILED",
        .succeeded = "SUCCEEDED",
        .in_progress = "IN_PROGRESS",
    };
};
