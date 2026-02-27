/// Contains information about the security group for the load balancer.
pub const AwsElbLoadBalancerSourceSecurityGroup = struct {
    /// The name of the security group.
    group_name: ?[]const u8,

    /// The owner of the security group.
    owner_alias: ?[]const u8,

    pub const json_field_names = .{
        .group_name = "GroupName",
        .owner_alias = "OwnerAlias",
    };
};
