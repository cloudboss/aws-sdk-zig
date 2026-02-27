pub const Protocol = enum {
    tcp,
    icmp,

    pub const json_field_names = .{
        .tcp = "TCP",
        .icmp = "ICMP",
    };
};
