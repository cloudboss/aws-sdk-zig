pub const WorkforceIpAddressType = enum {
    ipv_4,
    dualstack,

    pub const json_field_names = .{
        .ipv_4 = "ipv4",
        .dualstack = "dualstack",
    };
};
