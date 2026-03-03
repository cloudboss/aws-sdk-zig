const ServiceRevisionLoadBalancer = @import("service_revision_load_balancer.zig").ServiceRevisionLoadBalancer;

/// The resolved configuration for a service revision, which contains the actual
/// resources your service revision uses, such as which target groups serve
/// traffic.
pub const ResolvedConfiguration = struct {
    /// The resolved load balancer configuration for the service revision. This
    /// includes information about which target groups serve traffic and which
    /// listener rules direct traffic to them.
    load_balancers: ?[]const ServiceRevisionLoadBalancer = null,

    pub const json_field_names = .{
        .load_balancers = "loadBalancers",
    };
};
