pub const Protocol = enum {
    mqtt,
    http,

    pub const json_field_names = .{
        .mqtt = "MQTT",
        .http = "HTTP",
    };
};
