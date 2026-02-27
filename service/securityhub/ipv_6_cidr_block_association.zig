/// An IPV6 CIDR block association.
pub const Ipv6CidrBlockAssociation = struct {
    /// The association ID for the IPv6 CIDR block.
    association_id: ?[]const u8,

    /// Information about the state of the CIDR block. Valid values are as follows:
    ///
    /// * `associating`
    ///
    /// * `associated`
    ///
    /// * `disassociating`
    ///
    /// * `disassociated`
    ///
    /// * `failed`
    ///
    /// * `failing`
    cidr_block_state: ?[]const u8,

    /// The IPv6 CIDR block.
    ipv_6_cidr_block: ?[]const u8,

    pub const json_field_names = .{
        .association_id = "AssociationId",
        .cidr_block_state = "CidrBlockState",
        .ipv_6_cidr_block = "Ipv6CidrBlock",
    };
};
