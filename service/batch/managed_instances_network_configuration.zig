/// The network configuration for Amazon ECS Managed Instances. Specifies the
/// VPC subnets and
/// security groups where instances are launched.
pub const ManagedInstancesNetworkConfiguration = struct {
    /// The VPC security groups to associate with the managed instances.
    security_groups: []const []const u8,

    /// The VPC subnets where managed instances are launched. If your subnets don't
    /// provide public
    /// IP addresses, they must have a NAT gateway for outbound internet access.
    subnets: []const []const u8,

    pub const json_field_names = .{
        .security_groups = "securityGroups",
        .subnets = "subnets",
    };
};
