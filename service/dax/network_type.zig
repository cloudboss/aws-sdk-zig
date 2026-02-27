pub const NetworkType = enum {
    ipv4,
    ipv6,
    dual_stack,

    pub const json_field_names = .{
        .ipv4 = "IPV4",
        .ipv6 = "IPV6",
        .dual_stack = "DUAL_STACK",
    };
};
