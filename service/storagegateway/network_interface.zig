/// Describes a gateway's network interface.
pub const NetworkInterface = struct {
    /// The Internet Protocol version 4 (IPv4) address of the interface.
    ipv_4_address: ?[]const u8,

    /// The Internet Protocol version 6 (IPv6) address of the interface.
    ///
    /// This element returns IPv6 addresses for all gateway types except FSx File
    /// Gateway.
    ipv_6_address: ?[]const u8,

    /// The Media Access Control (MAC) address of the interface.
    ///
    /// This is currently unsupported and will not be returned in output.
    mac_address: ?[]const u8,

    pub const json_field_names = .{
        .ipv_4_address = "Ipv4Address",
        .ipv_6_address = "Ipv6Address",
        .mac_address = "MacAddress",
    };
};
