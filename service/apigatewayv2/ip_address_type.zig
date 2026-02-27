/// The IP address types that can invoke your API or domain name.
pub const IpAddressType = enum {
    ipv_4,
    dualstack,

    pub const json_field_names = .{
        .ipv_4 = "ipv4",
        .dualstack = "dualstack",
    };
};
