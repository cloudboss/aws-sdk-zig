const IpAddresses = @import("ip_addresses.zig").IpAddresses;

/// The host property details.
pub const HostPropertiesRequest = struct {
    /// The host name.
    host_name: ?[]const u8,

    /// The IP address of the host.
    ip_addresses: ?IpAddresses,

    pub const json_field_names = .{
        .host_name = "hostName",
        .ip_addresses = "ipAddresses",
    };
};
