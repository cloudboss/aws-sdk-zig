/// A VPC security groups that the DB instance belongs to.
pub const AwsRdsDbInstanceVpcSecurityGroup = struct {
    /// The status of the VPC security group.
    status: ?[]const u8,

    /// The name of the VPC security group.
    vpc_security_group_id: ?[]const u8,

    pub const json_field_names = .{
        .status = "Status",
        .vpc_security_group_id = "VpcSecurityGroupId",
    };
};
