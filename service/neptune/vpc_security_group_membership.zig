/// This data type is used as a response element for queries on VPC security
/// group
/// membership.
pub const VpcSecurityGroupMembership = struct {
    /// The status of the VPC security group.
    status: ?[]const u8 = null,

    /// The name of the VPC security group.
    vpc_security_group_id: ?[]const u8 = null,
};
