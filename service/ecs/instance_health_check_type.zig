pub const InstanceHealthCheckType = enum {
    container_runtime,

    pub const json_field_names = .{
        .container_runtime = "CONTAINER_RUNTIME",
    };
};
