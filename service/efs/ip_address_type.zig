pub const IpAddressType = enum {
    ipv4_only,
    ipv6_only,
    dual_stack,

    pub const json_field_names = .{
        .ipv4_only = "IPV4_ONLY",
        .ipv6_only = "IPV6_ONLY",
        .dual_stack = "DUAL_STACK",
    };
};
