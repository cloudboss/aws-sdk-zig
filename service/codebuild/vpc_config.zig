/// Information about the VPC configuration that CodeBuild accesses.
pub const VpcConfig = struct {
    /// A list of one or more security groups IDs in your Amazon VPC.
    security_group_ids: ?[]const []const u8 = null,

    /// A list of one or more subnet IDs in your Amazon VPC.
    subnets: ?[]const []const u8 = null,

    /// The ID of the Amazon VPC.
    vpc_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .security_group_ids = "securityGroupIds",
        .subnets = "subnets",
        .vpc_id = "vpcId",
    };
};
