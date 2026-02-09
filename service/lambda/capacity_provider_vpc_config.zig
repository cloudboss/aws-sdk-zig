/// VPC configuration that specifies the network settings for compute instances
/// managed by the capacity provider.
pub const CapacityProviderVpcConfig = struct {
    /// A list of security group IDs that control network access for compute
    /// instances managed by the capacity provider.
    security_group_ids: []const []const u8,

    /// A list of subnet IDs where the capacity provider launches compute instances.
    subnet_ids: []const []const u8,
};
