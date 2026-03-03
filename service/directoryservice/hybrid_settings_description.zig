/// Describes the current hybrid directory configuration settings for a
/// directory.
pub const HybridSettingsDescription = struct {
    /// The IP addresses of the DNS servers in your self-managed AD environment.
    self_managed_dns_ip_addrs: ?[]const []const u8 = null,

    /// The identifiers of the self-managed instances with SSM used for hybrid
    /// directory
    /// operations.
    self_managed_instance_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .self_managed_dns_ip_addrs = "SelfManagedDnsIpAddrs",
        .self_managed_instance_ids = "SelfManagedInstanceIds",
    };
};
