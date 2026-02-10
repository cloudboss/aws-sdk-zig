/// Describes a VPC with a security group that references your security group.
pub const SecurityGroupReference = struct {
    /// The ID of your security group.
    group_id: ?[]const u8,

    /// The ID of the VPC with the referencing security group.
    referencing_vpc_id: ?[]const u8,

    /// The ID of the transit gateway (if applicable).
    transit_gateway_id: ?[]const u8,

    /// The ID of the VPC peering connection (if applicable). For more information
    /// about security group referencing for peering connections, see
    /// [Update your security groups to reference peer security
    /// groups](https://docs.aws.amazon.com/vpc/latest/peering/vpc-peering-security-groups.html)
    /// in the *VPC Peering Guide*.
    vpc_peering_connection_id: ?[]const u8,
};
