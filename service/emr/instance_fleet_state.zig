pub const InstanceFleetState = enum {
    provisioning,
    bootstrapping,
    running,
    resizing,
    reconfiguring,
    suspended,
    terminating,
    terminated,

    pub const json_field_names = .{
        .provisioning = "PROVISIONING",
        .bootstrapping = "BOOTSTRAPPING",
        .running = "RUNNING",
        .resizing = "RESIZING",
        .reconfiguring = "RECONFIGURING",
        .suspended = "SUSPENDED",
        .terminating = "TERMINATING",
        .terminated = "TERMINATED",
    };
};
