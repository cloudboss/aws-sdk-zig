/// Network interface.
pub const NetworkInterface = struct {
    /// Network interface IPs.
    ips: ?[]const []const u8,

    /// Whether this is the primary network interface.
    is_primary: ?bool,

    /// The MAC address of the network interface.
    mac_address: ?[]const u8,

    pub const json_field_names = .{
        .ips = "ips",
        .is_primary = "isPrimary",
        .mac_address = "macAddress",
    };
};
