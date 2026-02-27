pub const MemoryRecordStatus = enum {
    succeeded,
    failed,

    pub const json_field_names = .{
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
    };
};
