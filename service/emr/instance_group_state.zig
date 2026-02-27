pub const InstanceGroupState = enum {
    provisioning,
    bootstrapping,
    running,
    reconfiguring,
    resizing,
    suspended,
    terminating,
    terminated,
    arrested,
    shutting_down,
    ended,

    pub const json_field_names = .{
        .provisioning = "PROVISIONING",
        .bootstrapping = "BOOTSTRAPPING",
        .running = "RUNNING",
        .reconfiguring = "RECONFIGURING",
        .resizing = "RESIZING",
        .suspended = "SUSPENDED",
        .terminating = "TERMINATING",
        .terminated = "TERMINATED",
        .arrested = "ARRESTED",
        .shutting_down = "SHUTTING_DOWN",
        .ended = "ENDED",
    };
};
