pub const CisScanStatus = enum {
    failed,
    completed,
    cancelled,
    in_progress,

    pub const json_field_names = .{
        .failed = "FAILED",
        .completed = "COMPLETED",
        .cancelled = "CANCELLED",
        .in_progress = "IN_PROGRESS",
    };
};
