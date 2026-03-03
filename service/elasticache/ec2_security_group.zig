/// Provides ownership and status information for an Amazon EC2 security group.
pub const EC2SecurityGroup = struct {
    /// The name of the Amazon EC2 security group.
    ec2_security_group_name: ?[]const u8 = null,

    /// The Amazon account ID of the Amazon EC2 security group owner.
    ec2_security_group_owner_id: ?[]const u8 = null,

    /// The status of the Amazon EC2 security group.
    status: ?[]const u8 = null,
};
