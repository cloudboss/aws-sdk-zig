/// The VPC configuration for a pentest, specifying the VPC, security groups,
/// and subnets to use during testing.
pub const VpcConfig = struct {
    /// The Amazon Resource Names (ARNs) or IDs of the security groups for the VPC
    /// configuration.
    security_group_arns: ?[]const []const u8 = null,

    /// The Amazon Resource Names (ARNs) or IDs of the subnets for the VPC
    /// configuration.
    subnet_arns: ?[]const []const u8 = null,

    /// The Amazon Resource Name (ARN) or ID of the VPC.
    vpc_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .security_group_arns = "securityGroupArns",
        .subnet_arns = "subnetArns",
        .vpc_arn = "vpcArn",
    };
};
