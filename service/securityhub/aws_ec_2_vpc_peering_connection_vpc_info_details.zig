const VpcInfoCidrBlockSetDetails = @import("vpc_info_cidr_block_set_details.zig").VpcInfoCidrBlockSetDetails;
const VpcInfoIpv6CidrBlockSetDetails = @import("vpc_info_ipv_6_cidr_block_set_details.zig").VpcInfoIpv6CidrBlockSetDetails;
const VpcInfoPeeringOptionsDetails = @import("vpc_info_peering_options_details.zig").VpcInfoPeeringOptionsDetails;

/// Describes a VPC in a VPC peering connection.
pub const AwsEc2VpcPeeringConnectionVpcInfoDetails = struct {
    /// The IPv4 CIDR block for the VPC.
    cidr_block: ?[]const u8,

    /// Information about the IPv4 CIDR blocks for the VPC.
    cidr_block_set: ?[]const VpcInfoCidrBlockSetDetails,

    /// The IPv6 CIDR block for the VPC.
    ipv_6_cidr_block_set: ?[]const VpcInfoIpv6CidrBlockSetDetails,

    /// The ID of the Amazon Web Services account that owns the VPC.
    owner_id: ?[]const u8,

    /// Information about the VPC peering connection options for the accepter or
    /// requester VPC.
    peering_options: ?VpcInfoPeeringOptionsDetails,

    /// The Amazon Web Services Region in which the VPC is located.
    region: ?[]const u8,

    /// The ID of the VPC.
    vpc_id: ?[]const u8,

    pub const json_field_names = .{
        .cidr_block = "CidrBlock",
        .cidr_block_set = "CidrBlockSet",
        .ipv_6_cidr_block_set = "Ipv6CidrBlockSet",
        .owner_id = "OwnerId",
        .peering_options = "PeeringOptions",
        .region = "Region",
        .vpc_id = "VpcId",
    };
};
