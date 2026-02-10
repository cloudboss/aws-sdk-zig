/// Information about the IPv4 delegated prefixes assigned to a network
/// interface.
pub const Ipv4PrefixSpecificationResponse = struct {
    /// The IPv4 delegated prefixes assigned to the network interface.
    ipv_4_prefix: ?[]const u8,
};
