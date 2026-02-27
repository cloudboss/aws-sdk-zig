const LoadBalancerDescription = @import("load_balancer_description.zig").LoadBalancerDescription;

/// Contains the parameters for DescribeLoadBalancers.
pub const DescribeAccessPointsOutput = struct {
    /// Information about the load balancers.
    load_balancer_descriptions: ?[]const LoadBalancerDescription,

    /// The marker to use when requesting the next set of results. If there are no
    /// additional results, the string is empty.
    next_marker: ?[]const u8,
};
