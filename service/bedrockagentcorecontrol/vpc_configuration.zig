/// The VPC configuration for launching Amazon EC2 instances.
pub const VpcConfiguration = struct {
    /// The IDs of the security groups to associate with the instances. You must
    /// specify at least one security group.
    security_groups: []const []const u8,

    /// The IDs of the subnets in which to launch instances. You must specify at
    /// least one subnet.
    subnets: []const []const u8,

    pub const json_field_names = .{
        .security_groups = "securityGroups",
        .subnets = "subnets",
    };
};
