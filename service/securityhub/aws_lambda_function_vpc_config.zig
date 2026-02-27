/// The VPC security groups and subnets that are attached to a Lambda function.
pub const AwsLambdaFunctionVpcConfig = struct {
    /// A list of VPC security groups IDs.
    security_group_ids: ?[]const []const u8,

    /// A list of VPC subnet IDs.
    subnet_ids: ?[]const []const u8,

    /// The ID of the VPC.
    vpc_id: ?[]const u8,

    pub const json_field_names = .{
        .security_group_ids = "SecurityGroupIds",
        .subnet_ids = "SubnetIds",
        .vpc_id = "VpcId",
    };
};
