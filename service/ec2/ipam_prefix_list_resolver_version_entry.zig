/// Describes a CIDR entry in a specific version of an IPAM prefix list
/// resolver. This represents a CIDR that was selected and synchronized at a
/// particular point in time.
pub const IpamPrefixListResolverVersionEntry = struct {
    /// The CIDR block that was selected and synchronized in this resolver version.
    cidr: ?[]const u8 = null,
};
