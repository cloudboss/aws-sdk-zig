pub const NetworkType = enum {
    ipv4,
    dual,

    pub const json_field_names = .{
        .ipv4 = "IPV4",
        .dual = "DUAL",
    };
};
