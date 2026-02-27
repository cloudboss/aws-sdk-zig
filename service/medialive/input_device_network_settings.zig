const InputDeviceIpScheme = @import("input_device_ip_scheme.zig").InputDeviceIpScheme;

/// The network settings for the input device.
pub const InputDeviceNetworkSettings = struct {
    /// The DNS addresses of the input device.
    dns_addresses: ?[]const []const u8,

    /// The network gateway IP address.
    gateway: ?[]const u8,

    /// The IP address of the input device.
    ip_address: ?[]const u8,

    /// Specifies whether the input device has been configured (outside of
    /// MediaLive) to use a dynamic IP address assignment (DHCP) or a static IP
    /// address.
    ip_scheme: ?InputDeviceIpScheme,

    /// The subnet mask of the input device.
    subnet_mask: ?[]const u8,

    pub const json_field_names = .{
        .dns_addresses = "DnsAddresses",
        .gateway = "Gateway",
        .ip_address = "IpAddress",
        .ip_scheme = "IpScheme",
        .subnet_mask = "SubnetMask",
    };
};
