/// A VPC security group that the cluster belongs to, if the cluster is in a
/// VPC.
pub const AwsRedshiftClusterVpcSecurityGroup = struct {
    /// The status of the VPC security group.
    status: ?[]const u8 = null,

    /// The identifier of the VPC security group.
    vpc_security_group_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .status = "Status",
        .vpc_security_group_id = "VpcSecurityGroupId",
    };
};
