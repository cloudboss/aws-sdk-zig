pub const HsmStatus = enum {
    pending,
    running,
    updating,
    suspended,
    terminating,
    terminated,
    degraded,

    pub const json_field_names = .{
        .pending = "PENDING",
        .running = "RUNNING",
        .updating = "UPDATING",
        .suspended = "SUSPENDED",
        .terminating = "TERMINATING",
        .terminated = "TERMINATED",
        .degraded = "DEGRADED",
    };
};
