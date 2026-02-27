pub const ResolverEndpointType = enum {
    ipv6,
    ipv4,
    dualstack,

    pub const json_field_names = .{
        .ipv6 = "IPV6",
        .ipv4 = "IPV4",
        .dualstack = "DUALSTACK",
    };
};
