/// Contains information about an Autonomous System Number (ASN) registered at
/// an internet registry and associated with an IPAM.
pub const IpamInternetRegistryAssociationAsn = struct {
    /// The Autonomous System Number.
    asn: ?[]const u8 = null,

    /// The time when the ASN was last observed at the internet registry.
    last_observed_at: ?i64 = null,
};
