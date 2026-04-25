/// VPC configuration for workflow runs.
pub const VpcConfig = struct {
    /// List of security group IDs. Maximum of 5 security groups allowed.
    security_group_ids: ?[]const []const u8 = null,

    /// List of subnet IDs. Maximum of 16 subnets allowed.
    subnet_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .security_group_ids = "securityGroupIds",
        .subnet_ids = "subnetIds",
    };
};
