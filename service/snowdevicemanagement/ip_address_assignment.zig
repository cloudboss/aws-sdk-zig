pub const IpAddressAssignment = enum {
    dhcp,
    static,

    pub const json_field_names = .{
        .dhcp = "DHCP",
        .static = "STATIC",
    };
};
