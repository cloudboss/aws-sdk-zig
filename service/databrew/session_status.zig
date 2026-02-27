pub const SessionStatus = enum {
    assigned,
    failed,
    initializing,
    provisioning,
    ready,
    recycling,
    rotating,
    terminated,
    terminating,
    updating,

    pub const json_field_names = .{
        .assigned = "ASSIGNED",
        .failed = "FAILED",
        .initializing = "INITIALIZING",
        .provisioning = "PROVISIONING",
        .ready = "READY",
        .recycling = "RECYCLING",
        .rotating = "ROTATING",
        .terminated = "TERMINATED",
        .terminating = "TERMINATING",
        .updating = "UPDATING",
    };
};
