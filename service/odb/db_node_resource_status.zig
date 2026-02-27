pub const DbNodeResourceStatus = enum {
    available,
    failed,
    provisioning,
    terminated,
    terminating,
    updating,
    stopping,
    stopped,
    starting,

    pub const json_field_names = .{
        .available = "AVAILABLE",
        .failed = "FAILED",
        .provisioning = "PROVISIONING",
        .terminated = "TERMINATED",
        .terminating = "TERMINATING",
        .updating = "UPDATING",
        .stopping = "STOPPING",
        .stopped = "STOPPED",
        .starting = "STARTING",
    };
};
