pub const IPSetDescriptorType = enum {
    ipv4,
    ipv6,

    pub const json_field_names = .{
        .ipv4 = "IPV4",
        .ipv6 = "IPV6",
    };
};
