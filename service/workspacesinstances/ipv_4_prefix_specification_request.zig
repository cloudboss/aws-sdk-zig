/// Specifies IPv4 prefix configuration for network interfaces.
pub const Ipv4PrefixSpecificationRequest = struct {
    /// Specific IPv4 prefix for network interface configuration.
    ipv_4_prefix: ?[]const u8,

    pub const json_field_names = .{
        .ipv_4_prefix = "Ipv4Prefix",
    };
};
