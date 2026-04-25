/// VPC configuration for workflow runs with computed VPC ID.
pub const VpcConfigResponse = struct {
    /// List of security group IDs.
    security_group_ids: ?[]const []const u8 = null,

    /// List of subnet IDs.
    subnet_ids: ?[]const []const u8 = null,

    /// VPC ID computed from the provided subnet IDs.
    vpc_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .security_group_ids = "securityGroupIds",
        .subnet_ids = "subnetIds",
        .vpc_id = "vpcId",
    };
};
