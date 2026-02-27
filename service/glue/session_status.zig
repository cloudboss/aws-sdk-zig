pub const SessionStatus = enum {
    provisioning,
    ready,
    failed,
    timeout,
    stopping,
    stopped,

    pub const json_field_names = .{
        .provisioning = "PROVISIONING",
        .ready = "READY",
        .failed = "FAILED",
        .timeout = "TIMEOUT",
        .stopping = "STOPPING",
        .stopped = "STOPPED",
    };
};
