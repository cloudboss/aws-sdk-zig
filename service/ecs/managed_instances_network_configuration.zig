/// The network configuration for Amazon ECS Managed Instances. This specifies
/// the VPC
/// subnets and security groups that instances use for network connectivity.
/// Amazon ECS
/// Managed Instances support multiple network modes including `awsvpc`
/// (instances receive ENIs for task isolation), `host` (instances share network
/// namespace with tasks), and `none` (no external network connectivity),
/// ensuring backward compatibility for migrating workloads from Fargate or
/// Amazon
/// EC2.
pub const ManagedInstancesNetworkConfiguration = struct {
    /// The list of security group IDs to apply to Amazon ECS Managed Instances.
    /// These
    /// security groups control the network traffic allowed to and from the
    /// instances.
    security_groups: ?[]const []const u8,

    /// The list of subnet IDs where Amazon ECS can launch Amazon ECS Managed
    /// Instances.
    /// Instances are distributed across the specified subnets for high
    /// availability. All
    /// subnets must be in the same VPC.
    subnets: ?[]const []const u8,

    pub const json_field_names = .{
        .security_groups = "securityGroups",
        .subnets = "subnets",
    };
};
