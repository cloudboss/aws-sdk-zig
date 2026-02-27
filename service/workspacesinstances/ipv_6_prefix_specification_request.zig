/// Specifies IPv6 prefix configuration for network interfaces.
pub const Ipv6PrefixSpecificationRequest = struct {
    /// Specific IPv6 prefix for network interface configuration.
    ipv_6_prefix: ?[]const u8,

    pub const json_field_names = .{
        .ipv_6_prefix = "Ipv6Prefix",
    };
};
