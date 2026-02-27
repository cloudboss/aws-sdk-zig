/// Information about the VPC configuration that CodeBuild accesses.
pub const AwsCodeBuildProjectVpcConfig = struct {
    /// A list of one or more security group IDs in your VPC.
    security_group_ids: ?[]const []const u8,

    /// A list of one or more subnet IDs in your VPC.
    subnets: ?[]const []const u8,

    /// The ID of the VPC.
    vpc_id: ?[]const u8,

    pub const json_field_names = .{
        .security_group_ids = "SecurityGroupIds",
        .subnets = "Subnets",
        .vpc_id = "VpcId",
    };
};
