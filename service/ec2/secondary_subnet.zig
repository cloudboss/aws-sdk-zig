const SecondarySubnetIpv4CidrBlockAssociation = @import("secondary_subnet_ipv_4_cidr_block_association.zig").SecondarySubnetIpv4CidrBlockAssociation;
const SecondaryNetworkType = @import("secondary_network_type.zig").SecondaryNetworkType;
const SecondarySubnetState = @import("secondary_subnet_state.zig").SecondarySubnetState;
const Tag = @import("tag.zig").Tag;

/// Describes a secondary subnet.
pub const SecondarySubnet = struct {
    /// The Availability Zone of the secondary subnet.
    availability_zone: ?[]const u8 = null,

    /// The ID of the Availability Zone of the secondary subnet.
    availability_zone_id: ?[]const u8 = null,

    /// Information about the IPv4 CIDR blocks associated with the secondary subnet.
    ipv_4_cidr_block_associations: ?[]const SecondarySubnetIpv4CidrBlockAssociation = null,

    /// The ID of the Amazon Web Services account that owns the secondary subnet.
    owner_id: ?[]const u8 = null,

    /// The ID of the secondary network.
    secondary_network_id: ?[]const u8 = null,

    /// The type of the secondary network.
    secondary_network_type: ?SecondaryNetworkType = null,

    /// The Amazon Resource Name (ARN) of the secondary subnet.
    secondary_subnet_arn: ?[]const u8 = null,

    /// The ID of the secondary subnet.
    secondary_subnet_id: ?[]const u8 = null,

    /// The state of the secondary subnet.
    state: ?SecondarySubnetState = null,

    /// The reason for the current state of the secondary subnet.
    state_reason: ?[]const u8 = null,

    /// The tags assigned to the secondary subnet.
    tags: ?[]const Tag = null,
};
