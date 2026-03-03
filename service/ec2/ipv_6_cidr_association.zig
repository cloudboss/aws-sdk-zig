/// Describes an IPv6 CIDR block association.
pub const Ipv6CidrAssociation = struct {
    /// The resource that's associated with the IPv6 CIDR block.
    associated_resource: ?[]const u8 = null,

    /// The IPv6 CIDR block.
    ipv_6_cidr: ?[]const u8 = null,
};
