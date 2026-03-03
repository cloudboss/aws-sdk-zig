const VpcCidrBlockState = @import("vpc_cidr_block_state.zig").VpcCidrBlockState;

/// Describes an IPv4 CIDR block associated with a VPC.
pub const VpcCidrBlockAssociation = struct {
    /// The association ID for the IPv4 CIDR block.
    association_id: ?[]const u8 = null,

    /// The IPv4 CIDR block.
    cidr_block: ?[]const u8 = null,

    /// Information about the state of the CIDR block.
    cidr_block_state: ?VpcCidrBlockState = null,
};
