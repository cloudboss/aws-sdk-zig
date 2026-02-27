pub const Status = enum {
    running,
    failed,
    successful,

    pub const json_field_names = .{
        .running = "RUNNING",
        .failed = "FAILED",
        .successful = "SUCCESSFUL",
    };
};
