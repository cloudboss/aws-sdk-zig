/// EC2 security group information for an RDS DB security group.
pub const AwsRdsDbSecurityGroupEc2SecurityGroup = struct {
    /// Specifies the ID for the EC2 security group.
    ec_2_security_group_id: ?[]const u8 = null,

    /// Specifies the name of the EC2 security group.
    ec_2_security_group_name: ?[]const u8 = null,

    /// Provides the Amazon Web Services ID of the owner of the EC2 security group.
    ec_2_security_group_owner_id: ?[]const u8 = null,

    /// Provides the status of the EC2 security group.
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .ec_2_security_group_id = "Ec2SecurityGroupId",
        .ec_2_security_group_name = "Ec2SecurityGroupName",
        .ec_2_security_group_owner_id = "Ec2SecurityGroupOwnerId",
        .status = "Status",
    };
};
