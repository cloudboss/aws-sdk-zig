pub const SessionStatus = enum {
    in_progress,
    failed,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .failed = "FAILED",
    };
};
