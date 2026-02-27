pub const InstanceState = enum {
    awaiting_fulfillment,
    provisioning,
    bootstrapping,
    running,
    terminated,

    pub const json_field_names = .{
        .awaiting_fulfillment = "AWAITING_FULFILLMENT",
        .provisioning = "PROVISIONING",
        .bootstrapping = "BOOTSTRAPPING",
        .running = "RUNNING",
        .terminated = "TERMINATED",
    };
};
