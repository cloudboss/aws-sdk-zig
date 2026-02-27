pub const IpAddressType = enum {
    /// Indicates IPv4 address type
    ipv4,
    /// Indicates IPv6 address type
    ipv6,

    pub const json_field_names = .{
        .ipv4 = "IPV4",
        .ipv6 = "IPV6",
    };
};
