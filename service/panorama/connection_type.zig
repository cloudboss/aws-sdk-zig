pub const ConnectionType = enum {
    static_ip,
    dhcp,

    pub const json_field_names = .{
        .static_ip = "STATIC_IP",
        .dhcp = "DHCP",
    };
};
