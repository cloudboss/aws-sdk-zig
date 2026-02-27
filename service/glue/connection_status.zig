pub const ConnectionStatus = enum {
    ready,
    in_progress,
    failed,

    pub const json_field_names = .{
        .ready = "READY",
        .in_progress = "IN_PROGRESS",
        .failed = "FAILED",
    };
};
