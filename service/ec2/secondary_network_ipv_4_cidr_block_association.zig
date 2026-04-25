const SecondaryNetworkCidrBlockAssociationState = @import("secondary_network_cidr_block_association_state.zig").SecondaryNetworkCidrBlockAssociationState;

/// Describes an IPv4 CIDR block associated with a secondary network.
pub const SecondaryNetworkIpv4CidrBlockAssociation = struct {
    /// The association ID for the IPv4 CIDR block.
    association_id: ?[]const u8 = null,

    /// The IPv4 CIDR block.
    cidr_block: ?[]const u8 = null,

    /// The state of the CIDR block association.
    state: ?SecondaryNetworkCidrBlockAssociationState = null,

    /// The reason for the current state of the CIDR block association.
    state_reason: ?[]const u8 = null,
};
