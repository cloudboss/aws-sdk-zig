pub const TransportProtocol = enum {
    tcp,
    udp,

    pub const json_field_names = .{
        .tcp = "TCP",
        .udp = "UDP",
    };
};
