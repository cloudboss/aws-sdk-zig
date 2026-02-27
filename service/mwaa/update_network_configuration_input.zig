/// Defines the VPC networking components used to secure and enable network
/// traffic between the Amazon Web Services resources for your environment. For
/// more information, see [About networking on Amazon
/// MWAA](https://docs.aws.amazon.com/mwaa/latest/userguide/networking-about.html).
pub const UpdateNetworkConfigurationInput = struct {
    /// A list of security group IDs. A security group must be attached to the same
    /// VPC as the subnets. For more information, see [Security in your VPC on
    /// Amazon
    /// MWAA](https://docs.aws.amazon.com/mwaa/latest/userguide/vpc-security.html).
    security_group_ids: []const []const u8,

    pub const json_field_names = .{
        .security_group_ids = "SecurityGroupIds",
    };
};
