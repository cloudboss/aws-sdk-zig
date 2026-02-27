pub const ExportFilesStatus = enum {
    succeeded,
    failed,
    pending,

    pub const json_field_names = .{
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
        .pending = "PENDING",
    };
};
