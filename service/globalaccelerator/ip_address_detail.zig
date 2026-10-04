/// Detailed information for the IP addresses assigned to the Global
/// Accelerator.
pub const IpAddressDetail = struct {
    /// The static IP address.
    ip_address: ?[]const u8 = null,

    /// The network zone that the specified IP address is located on.
    network_zone: ?[]const u8 = null,

    pub const json_field_names = .{
        .ip_address = "IpAddress",
        .network_zone = "NetworkZone",
    };
};
