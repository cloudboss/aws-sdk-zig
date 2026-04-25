const SecondaryNetworkIpv4CidrBlockAssociation = @import("secondary_network_ipv_4_cidr_block_association.zig").SecondaryNetworkIpv4CidrBlockAssociation;
const SecondaryNetworkState = @import("secondary_network_state.zig").SecondaryNetworkState;
const Tag = @import("tag.zig").Tag;
const SecondaryNetworkType = @import("secondary_network_type.zig").SecondaryNetworkType;

/// Describes a secondary network.
pub const SecondaryNetwork = struct {
    /// Information about the IPv4 CIDR blocks associated with the secondary
    /// network.
    ipv_4_cidr_block_associations: ?[]const SecondaryNetworkIpv4CidrBlockAssociation = null,

    /// The ID of the Amazon Web Services account that owns the secondary network.
    owner_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the secondary network.
    secondary_network_arn: ?[]const u8 = null,

    /// The ID of the secondary network.
    secondary_network_id: ?[]const u8 = null,

    /// The state of the secondary network.
    state: ?SecondaryNetworkState = null,

    /// The reason for the current state of the secondary network.
    state_reason: ?[]const u8 = null,

    /// The tags assigned to the secondary network.
    tags: ?[]const Tag = null,

    /// The type of the secondary network.
    @"type": ?SecondaryNetworkType = null,
};
