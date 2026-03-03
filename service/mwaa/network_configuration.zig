/// Describes the VPC networking components used to secure and enable network
/// traffic between the Amazon Web Services resources for your environment. For
/// more information, see [About networking on Amazon
/// MWAA](https://docs.aws.amazon.com/mwaa/latest/userguide/networking-about.html).
pub const NetworkConfiguration = struct {
    /// A list of security group IDs. For more information, see [Security in your
    /// VPC on Amazon
    /// MWAA](https://docs.aws.amazon.com/mwaa/latest/userguide/vpc-security.html).
    security_group_ids: ?[]const []const u8 = null,

    /// A list of subnet IDs. For more information, see [About networking on Amazon
    /// MWAA](https://docs.aws.amazon.com/mwaa/latest/userguide/networking-about.html).
    subnet_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .security_group_ids = "SecurityGroupIds",
        .subnet_ids = "SubnetIds",
    };
};
