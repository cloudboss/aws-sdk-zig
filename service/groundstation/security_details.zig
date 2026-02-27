/// Information about endpoints.
pub const SecurityDetails = struct {
    /// ARN to a role needed for connecting streams to your instances.
    role_arn: []const u8,

    /// The security groups to attach to the elastic network interfaces.
    security_group_ids: []const []const u8,

    /// A list of subnets where AWS Ground Station places elastic network interfaces
    /// to send streams to your instances.
    subnet_ids: []const []const u8,

    pub const json_field_names = .{
        .role_arn = "roleArn",
        .security_group_ids = "securityGroupIds",
        .subnet_ids = "subnetIds",
    };
};
