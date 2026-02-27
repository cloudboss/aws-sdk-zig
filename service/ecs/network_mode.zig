pub const NetworkMode = enum {
    bridge,
    host,
    awsvpc,
    none,

    pub const json_field_names = .{
        .bridge = "BRIDGE",
        .host = "HOST",
        .awsvpc = "AWSVPC",
        .none = "NONE",
    };
};
