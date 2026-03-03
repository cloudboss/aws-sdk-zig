const BlockPublicAccessStates = @import("block_public_access_states.zig").BlockPublicAccessStates;
const VpcCidrBlockAssociation = @import("vpc_cidr_block_association.zig").VpcCidrBlockAssociation;
const VpcEncryptionControl = @import("vpc_encryption_control.zig").VpcEncryptionControl;
const Tenancy = @import("tenancy.zig").Tenancy;
const VpcIpv6CidrBlockAssociation = @import("vpc_ipv_6_cidr_block_association.zig").VpcIpv6CidrBlockAssociation;
const VpcState = @import("vpc_state.zig").VpcState;
const Tag = @import("tag.zig").Tag;

/// Describes a VPC.
pub const Vpc = struct {
    /// The state of VPC Block Public Access (BPA).
    block_public_access_states: ?BlockPublicAccessStates = null,

    /// The primary IPv4 CIDR block for the VPC.
    cidr_block: ?[]const u8 = null,

    /// Information about the IPv4 CIDR blocks associated with the VPC.
    cidr_block_association_set: ?[]const VpcCidrBlockAssociation = null,

    /// The ID of the set of DHCP options you've associated with the VPC.
    dhcp_options_id: ?[]const u8 = null,

    encryption_control: ?VpcEncryptionControl = null,

    /// The allowed tenancy of instances launched into the VPC.
    instance_tenancy: ?Tenancy = null,

    /// Information about the IPv6 CIDR blocks associated with the VPC.
    ipv_6_cidr_block_association_set: ?[]const VpcIpv6CidrBlockAssociation = null,

    /// Indicates whether the VPC is the default VPC.
    is_default: ?bool = null,

    /// The ID of the Amazon Web Services account that owns the VPC.
    owner_id: ?[]const u8 = null,

    /// The current state of the VPC.
    state: ?VpcState = null,

    /// Any tags assigned to the VPC.
    tags: ?[]const Tag = null,

    /// The ID of the VPC.
    vpc_id: ?[]const u8 = null,
};
