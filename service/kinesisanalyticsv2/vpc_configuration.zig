/// Describes the parameters of a VPC used by the application.
pub const VpcConfiguration = struct {
    /// The array of
    /// [SecurityGroup](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_SecurityGroup.html)
    /// IDs used by the VPC configuration.
    security_group_ids: []const []const u8,

    /// The array of
    /// [Subnet](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_Subnet.html) IDs
    /// used by the VPC configuration.
    subnet_ids: []const []const u8,

    pub const json_field_names = .{
        .security_group_ids = "SecurityGroupIds",
        .subnet_ids = "SubnetIds",
    };
};
