/// Describes the IPv6 prefix option for a network interface.
pub const Ipv6PrefixSpecificationRequest = struct {
    /// The IPv6 prefix.
    ipv_6_prefix: ?[]const u8,
};
