/// A static IP configuration.
pub const StaticIpConnectionInfo = struct {
    /// The connection's default gateway.
    default_gateway: []const u8,

    /// The connection's DNS address.
    dns: []const []const u8,

    /// The connection's IP address.
    ip_address: []const u8,

    /// The connection's DNS mask.
    mask: []const u8,

    pub const json_field_names = .{
        .default_gateway = "DefaultGateway",
        .dns = "Dns",
        .ip_address = "IpAddress",
        .mask = "Mask",
    };
};
