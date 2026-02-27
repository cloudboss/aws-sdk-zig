pub const NetworkProtocol = enum {
    tcp,
    all,
    udp,
    icmp,
    icmpv6,

    pub const json_field_names = .{
        .tcp = "TCP",
        .all = "ALL",
        .udp = "UDP",
        .icmp = "ICMP",
        .icmpv6 = "ICMPV6",
    };
};
