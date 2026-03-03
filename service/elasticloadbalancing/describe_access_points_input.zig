/// Contains the parameters for DescribeLoadBalancers.
pub const DescribeAccessPointsInput = struct {
    /// The names of the load balancers.
    load_balancer_names: ?[]const []const u8 = null,

    /// The marker for the next set of results. (You received this marker from a
    /// previous call.)
    marker: ?[]const u8 = null,

    /// The maximum number of results to return with this call (a number from 1 to
    /// 400). The default is 400.
    page_size: ?i32 = null,
};
