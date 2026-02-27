pub const DataLakeStatus = enum {
    initialized,
    pending,
    completed,
    failed,

    pub const json_field_names = .{
        .initialized = "INITIALIZED",
        .pending = "PENDING",
        .completed = "COMPLETED",
        .failed = "FAILED",
    };
};
