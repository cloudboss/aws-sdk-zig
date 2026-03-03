/// This data type is used as a response element in the following actions:
///
/// * `AuthorizeDBSecurityGroupIngress`
/// * `DescribeDBSecurityGroups`
/// * `RevokeDBSecurityGroupIngress`
pub const EC2SecurityGroup = struct {
    /// Specifies the id of the EC2 security group.
    ec2_security_group_id: ?[]const u8 = null,

    /// Specifies the name of the EC2 security group.
    ec2_security_group_name: ?[]const u8 = null,

    /// Specifies the Amazon Web Services ID of the owner of the EC2 security group
    /// specified in the `EC2SecurityGroupName` field.
    ec2_security_group_owner_id: ?[]const u8 = null,

    /// Provides the status of the EC2 security group. Status can be "authorizing",
    /// "authorized", "revoking", and "revoked".
    status: ?[]const u8 = null,
};
