/// The configuration of the Amazon VPCs for the cluster.
pub const VpcConfig = struct {
    /// The IDs of the security groups associated with the cluster.
    security_group_ids: ?[]const []const u8 = null,

    /// The IDs of the subnets associated with the cluster.
    subnet_ids: []const []const u8,

    pub const json_field_names = .{
        .security_group_ids = "SecurityGroupIds",
        .subnet_ids = "SubnetIds",
    };
};
