const LoadBalancerDescription = @import("load_balancer_description.zig").LoadBalancerDescription;

/// Describes the Amazon Web Services resources in use by this environment. This
/// data is not live
/// data.
pub const EnvironmentResourcesDescription = struct {
    /// Describes the LoadBalancer.
    load_balancer: ?LoadBalancerDescription = null,
};
