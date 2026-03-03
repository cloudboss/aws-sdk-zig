/// Network interface.
pub const NetworkInterface = struct {
    /// Network interface IPs.
    ips: ?[]const []const u8 = null,

    /// Network interface primary IP.
    is_primary: ?bool = null,

    /// Network interface Mac address.
    mac_address: ?[]const u8 = null,

    pub const json_field_names = .{
        .ips = "ips",
        .is_primary = "isPrimary",
        .mac_address = "macAddress",
    };
};
