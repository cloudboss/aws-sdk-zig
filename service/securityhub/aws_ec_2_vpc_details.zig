const CidrBlockAssociation = @import("cidr_block_association.zig").CidrBlockAssociation;
const Ipv6CidrBlockAssociation = @import("ipv_6_cidr_block_association.zig").Ipv6CidrBlockAssociation;

/// Details about an EC2 VPC.
pub const AwsEc2VpcDetails = struct {
    /// Information about the IPv4 CIDR blocks associated with the VPC.
    cidr_block_association_set: ?[]const CidrBlockAssociation,

    /// The identifier of the set of Dynamic Host Configuration Protocol (DHCP)
    /// options that are
    /// associated with the VPC. If the default options are associated with the VPC,
    /// then this is
    /// default.
    dhcp_options_id: ?[]const u8,

    /// Information about the IPv6 CIDR blocks associated with the VPC.
    ipv_6_cidr_block_association_set: ?[]const Ipv6CidrBlockAssociation,

    /// The current state of the VPC. Valid values are `available` or `pending`.
    state: ?[]const u8,

    pub const json_field_names = .{
        .cidr_block_association_set = "CidrBlockAssociationSet",
        .dhcp_options_id = "DhcpOptionsId",
        .ipv_6_cidr_block_association_set = "Ipv6CidrBlockAssociationSet",
        .state = "State",
    };
};
