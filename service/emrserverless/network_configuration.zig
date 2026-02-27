/// The network configuration for customer VPC connectivity.
pub const NetworkConfiguration = struct {
    /// The array of security group Ids for customer VPC connectivity.
    security_group_ids: ?[]const []const u8,

    /// The array of subnet Ids for customer VPC connectivity.
    subnet_ids: ?[]const []const u8,

    pub const json_field_names = .{
        .security_group_ids = "securityGroupIds",
        .subnet_ids = "subnetIds",
    };
};
