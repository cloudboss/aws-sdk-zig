/// Contains the configuration values for a hybrid directory update, including
/// Amazon Web Services
/// System Manager managed node and DNS information.
pub const HybridUpdateValue = struct {
    /// The IP addresses of the DNS servers or domain controllers in the hybrid
    /// directory
    /// configuration.
    dns_ips: ?[]const []const u8,

    /// The identifiers of the self-managed instances with SSM in the hybrid
    /// directory
    /// configuration.
    instance_ids: ?[]const []const u8,

    pub const json_field_names = .{
        .dns_ips = "DnsIps",
        .instance_ids = "InstanceIds",
    };
};
