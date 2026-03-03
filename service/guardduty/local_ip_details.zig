/// Contains information about the local IP address of the connection.
pub const LocalIpDetails = struct {
    /// The IPv4 local address of the connection.
    ip_address_v4: ?[]const u8 = null,

    /// The IPv6 local address of the connection.
    ip_address_v6: ?[]const u8 = null,

    pub const json_field_names = .{
        .ip_address_v4 = "IpAddressV4",
        .ip_address_v6 = "IpAddressV6",
    };
};
