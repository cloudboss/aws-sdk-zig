/// The configuration of a virtual private cloud (VPC). For more information,
/// see [Protect your data using Amazon Virtual Private Cloud and Amazon Web
/// Services
/// PrivateLink](https://docs.aws.amazon.com/bedrock/latest/userguide/usingVPC.html).
pub const VpcConfig = struct {
    /// An array of IDs for each security group in the VPC to use.
    security_group_ids: []const []const u8,

    /// An array of IDs for each subnet in the VPC to use.
    subnet_ids: []const []const u8,

    pub const json_field_names = .{
        .security_group_ids = "securityGroupIds",
        .subnet_ids = "subnetIds",
    };
};
