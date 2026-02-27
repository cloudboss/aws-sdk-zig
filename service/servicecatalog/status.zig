pub const Status = enum {
    available,
    creating,
    failed,

    pub const json_field_names = .{
        .available = "AVAILABLE",
        .creating = "CREATING",
        .failed = "FAILED",
    };
};
