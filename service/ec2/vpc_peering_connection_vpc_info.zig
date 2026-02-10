const CidrBlock = @import("cidr_block.zig").CidrBlock;
const Ipv6CidrBlock = @import("ipv_6_cidr_block.zig").Ipv6CidrBlock;
const VpcPeeringConnectionOptionsDescription = @import("vpc_peering_connection_options_description.zig").VpcPeeringConnectionOptionsDescription;

/// Describes a VPC in a VPC peering connection.
pub const VpcPeeringConnectionVpcInfo = struct {
    /// The IPv4 CIDR block for the VPC.
    cidr_block: ?[]const u8,

    /// Information about the IPv4 CIDR blocks for the VPC.
    cidr_block_set: ?[]const CidrBlock,

    /// The IPv6 CIDR block for the VPC.
    ipv_6_cidr_block_set: ?[]const Ipv6CidrBlock,

    /// The ID of the Amazon Web Services account that owns the VPC.
    owner_id: ?[]const u8,

    /// Information about the VPC peering connection options for the accepter or
    /// requester VPC.
    peering_options: ?VpcPeeringConnectionOptionsDescription,

    /// The Region in which the VPC is located.
    region: ?[]const u8,

    /// The ID of the VPC.
    vpc_id: ?[]const u8,
};
