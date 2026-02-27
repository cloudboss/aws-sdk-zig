pub const ExportStatus = enum {
    pending,
    started,
    failed,
    succeeded,

    pub const json_field_names = .{
        .pending = "PENDING",
        .started = "STARTED",
        .failed = "FAILED",
        .succeeded = "SUCCEEDED",
    };
};
