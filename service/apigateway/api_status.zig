pub const ApiStatus = enum {
    updating,
    available,
    pending,
    failed,

    pub const json_field_names = .{
        .updating = "UPDATING",
        .available = "AVAILABLE",
        .pending = "PENDING",
        .failed = "FAILED",
    };
};
