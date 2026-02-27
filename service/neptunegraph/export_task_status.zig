pub const ExportTaskStatus = enum {
    initializing,
    exporting,
    succeeded,
    failed,
    cancelling,
    cancelled,
    deleted,

    pub const json_field_names = .{
        .initializing = "INITIALIZING",
        .exporting = "EXPORTING",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
        .cancelling = "CANCELLING",
        .cancelled = "CANCELLED",
        .deleted = "DELETED",
    };
};
