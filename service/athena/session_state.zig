pub const SessionState = enum {
    creating,
    created,
    idle,
    busy,
    terminating,
    terminated,
    degraded,
    failed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .created = "CREATED",
        .idle = "IDLE",
        .busy = "BUSY",
        .terminating = "TERMINATING",
        .terminated = "TERMINATED",
        .degraded = "DEGRADED",
        .failed = "FAILED",
    };
};
