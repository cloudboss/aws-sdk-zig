pub const KxNodeStatus = enum {
    running,
    provisioning,

    pub const json_field_names = .{
        .running = "RUNNING",
        .provisioning = "PROVISIONING",
    };
};
