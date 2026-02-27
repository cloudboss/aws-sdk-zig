pub const ResourceConfigurationIpAddressType = enum {
    /// Ipv4 ip address type for dns type resource configs
    ipv4,
    /// IPv6 ip address type for dns type resource configs
    ipv6,
    /// Dualstack ip address type for dns type resource configs
    dualstack,

    pub const json_field_names = .{
        .ipv4 = "IPV4",
        .ipv6 = "IPV6",
        .dualstack = "DUALSTACK",
    };
};
