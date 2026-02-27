/// Used as a response element for queries on virtual private cloud (VPC)
/// security group
/// membership.
pub const VpcSecurityGroupMembership = struct {
    /// The status of the VPC security group.
    status: ?[]const u8,

    /// The name of the VPC security group.
    vpc_security_group_id: ?[]const u8,
};
