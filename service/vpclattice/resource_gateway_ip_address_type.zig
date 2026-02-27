pub const ResourceGatewayIpAddressType = enum {
    /// Ipv4 ip address type for resource gateway
    ipv4,
    /// IPv6 ip address type for resource gateway
    ipv6,
    /// Dualstack ip address type for resource gateway
    dualstack,

    pub const json_field_names = .{
        .ipv4 = "IPV4",
        .ipv6 = "IPV6",
        .dualstack = "DUALSTACK",
    };
};
