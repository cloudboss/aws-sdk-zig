pub const IPAddressType = enum {
    dualstack,
    ipv4,
    ipv6,

    pub const json_field_names = .{
        .dualstack = "DUALSTACK",
        .ipv4 = "IPV4",
        .ipv6 = "IPV6",
    };
};
