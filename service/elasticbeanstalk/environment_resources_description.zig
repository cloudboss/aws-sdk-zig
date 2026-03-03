const LoadBalancerDescription = @import("load_balancer_description.zig").LoadBalancerDescription;

/// Describes the AWS resources in use by this environment. This data is not
/// live
/// data.
pub const EnvironmentResourcesDescription = struct {
    /// Describes the LoadBalancer.
    load_balancer: ?LoadBalancerDescription = null,
};
