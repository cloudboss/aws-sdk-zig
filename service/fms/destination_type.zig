pub const DestinationType = enum {
    ipv4,
    ipv6,
    prefix_list,

    pub const json_field_names = .{
        .ipv4 = "IPV4",
        .ipv6 = "IPV6",
        .prefix_list = "PrefixList",
    };
};
