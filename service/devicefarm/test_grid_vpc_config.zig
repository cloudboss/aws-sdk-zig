/// The VPC security groups and subnets that are attached to a project.
pub const TestGridVpcConfig = struct {
    /// A list of VPC security group IDs in your Amazon VPC.
    security_group_ids: []const []const u8,

    /// A list of VPC subnet IDs in your Amazon VPC.
    subnet_ids: []const []const u8,

    /// The ID of the Amazon VPC.
    vpc_id: []const u8,

    pub const json_field_names = .{
        .security_group_ids = "securityGroupIds",
        .subnet_ids = "subnetIds",
        .vpc_id = "vpcId",
    };
};
