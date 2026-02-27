pub const LogType = enum {
    alert,
    flow,
    tls,

    pub const json_field_names = .{
        .alert = "ALERT",
        .flow = "FLOW",
        .tls = "TLS",
    };
};
