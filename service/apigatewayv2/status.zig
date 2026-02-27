/// The status.
pub const Status = enum {
    available,
    in_progress,
    failed,

    pub const json_field_names = .{
        .available = "AVAILABLE",
        .in_progress = "IN_PROGRESS",
        .failed = "FAILED",
    };
};
