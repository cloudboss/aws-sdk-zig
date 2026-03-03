/// An IPv4 CIDR block association.
pub const CidrBlockAssociation = struct {
    /// The association ID for the IPv4 CIDR block.
    association_id: ?[]const u8 = null,

    /// The IPv4 CIDR block.
    cidr_block: ?[]const u8 = null,

    /// Information about the state of the IPv4 CIDR block.
    cidr_block_state: ?[]const u8 = null,

    pub const json_field_names = .{
        .association_id = "AssociationId",
        .cidr_block = "CidrBlock",
        .cidr_block_state = "CidrBlockState",
    };
};
