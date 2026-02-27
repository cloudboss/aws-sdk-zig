pub const UpdateStatus = enum {
    in_progress,
    failed,
    cancelled,
    successful,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .failed = "FAILED",
        .cancelled = "CANCELLED",
        .successful = "SUCCESSFUL",
    };
};
