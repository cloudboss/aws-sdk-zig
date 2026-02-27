pub const BuildStatus = enum {
    initialized,
    ready,
    failed,

    pub const json_field_names = .{
        .initialized = "INITIALIZED",
        .ready = "READY",
        .failed = "FAILED",
    };
};
