pub const EndpointType = enum {
    dualstack,
    ipv4,

    pub const json_field_names = .{
        .dualstack = "DUALSTACK",
        .ipv4 = "IPV4",
    };
};
