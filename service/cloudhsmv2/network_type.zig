pub const NetworkType = enum {
    ipv4,
    dualstack,

    pub const json_field_names = .{
        .ipv4 = "IPV4",
        .dualstack = "DUALSTACK",
    };
};
