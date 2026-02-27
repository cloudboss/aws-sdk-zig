/// The VPC security groups and subnets that are attached to an Amazon Web
/// Services Lambda
/// function. For more information, see [VPC
/// Settings](https://docs.aws.amazon.com/lambda/latest/dg/configuration-vpc.html).
pub const LambdaVpcConfig = struct {
    /// The VPC security groups and subnets that are attached to an Amazon Web
    /// Services Lambda
    /// function. For more information, see [VPC
    /// Settings](https://docs.aws.amazon.com/lambda/latest/dg/configuration-vpc.html).
    security_group_ids: ?[]const []const u8,

    /// A list of VPC subnet IDs.
    subnet_ids: ?[]const []const u8,

    /// The ID of the VPC.
    vpc_id: ?[]const u8,

    pub const json_field_names = .{
        .security_group_ids = "securityGroupIds",
        .subnet_ids = "subnetIds",
        .vpc_id = "vpcId",
    };
};
