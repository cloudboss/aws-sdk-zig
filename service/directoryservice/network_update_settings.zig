const NetworkType = @import("network_type.zig").NetworkType;

/// Contains the network configuration for directory update operations.
pub const NetworkUpdateSettings = struct {
    /// IPv6 addresses of DNS servers or domain controllers in the self-managed
    /// directory.
    /// Required only when updating an AD Connector directory.
    customer_dns_ips_v6: ?[]const []const u8,

    /// The target network type for the directory update.
    network_type: ?NetworkType,

    pub const json_field_names = .{
        .customer_dns_ips_v6 = "CustomerDnsIpsV6",
        .network_type = "NetworkType",
    };
};
