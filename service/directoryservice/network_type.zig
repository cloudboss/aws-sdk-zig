pub const NetworkType = enum {
    dual_stack,
    ipv4_only,
    ipv6_only,

    pub const json_field_names = .{
        .dual_stack = "DUAL_STACK",
        .ipv4_only = "IPV4_ONLY",
        .ipv6_only = "IPV6_ONLY",
    };
};
