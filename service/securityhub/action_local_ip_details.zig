/// Provides information about the IP address where the scanned port is located.
pub const ActionLocalIpDetails = struct {
    /// The IP address.
    ip_address_v4: ?[]const u8,

    pub const json_field_names = .{
        .ip_address_v4 = "IpAddressV4",
    };
};
