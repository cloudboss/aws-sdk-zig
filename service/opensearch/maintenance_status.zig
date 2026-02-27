pub const MaintenanceStatus = enum {
    pending,
    in_progress,
    completed,
    failed,
    timed_out,

    pub const json_field_names = .{
        .pending = "PENDING",
        .in_progress = "IN_PROGRESS",
        .completed = "COMPLETED",
        .failed = "FAILED",
        .timed_out = "TIMED_OUT",
    };
};
