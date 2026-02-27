pub const IpAddressType = enum {
    ipv4,
    dual_stack,

    pub const json_field_names = .{
        .ipv4 = "IPV4",
        .dual_stack = "DUAL_STACK",
    };
};
