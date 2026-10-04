/// Contains information about an IP address CIDR registered at an internet
/// registry and associated with an IPAM.
pub const IpamInternetRegistryAssociationCidr = struct {
    /// The IP address prefix in CIDR notation.
    cidr: ?[]const u8 = null,

    /// The time when the CIDR was last observed at the internet registry.
    last_observed_at: ?i64 = null,
};
