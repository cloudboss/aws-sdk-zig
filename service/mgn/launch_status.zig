pub const LaunchStatus = enum {
    pending,
    in_progress,
    launched,
    failed,
    terminated,

    pub const json_field_names = .{
        .pending = "PENDING",
        .in_progress = "IN_PROGRESS",
        .launched = "LAUNCHED",
        .failed = "FAILED",
        .terminated = "TERMINATED",
    };
};
