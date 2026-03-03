/// Information about the IPv6 delegated prefixes assigned to a network
/// interface.
pub const Ipv6PrefixSpecificationResponse = struct {
    /// The IPv6 delegated prefixes assigned to the network interface.
    ipv_6_prefix: ?[]const u8 = null,
};
