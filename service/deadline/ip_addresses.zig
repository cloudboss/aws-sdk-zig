/// The IP addresses for a host.
pub const IpAddresses = struct {
    /// The IpV4 address of the network.
    ip_v4_addresses: ?[]const []const u8,

    /// The IpV6 address for the network and node component.
    ip_v6_addresses: ?[]const []const u8,

    pub const json_field_names = .{
        .ip_v4_addresses = "ipV4Addresses",
        .ip_v6_addresses = "ipV6Addresses",
    };
};
