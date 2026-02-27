/// This data type is used as a response element for queries on VPC security
/// group membership.
pub const VpcSecurityGroupMembership = struct {
    /// The membership status of the VPC security group.
    ///
    /// Currently, the only valid status is `active`.
    status: ?[]const u8,

    /// The name of the VPC security group.
    vpc_security_group_id: ?[]const u8,
};
