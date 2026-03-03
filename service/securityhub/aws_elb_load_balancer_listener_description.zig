const AwsElbLoadBalancerListener = @import("aws_elb_load_balancer_listener.zig").AwsElbLoadBalancerListener;

/// Lists the policies that are enabled for a load balancer listener.
pub const AwsElbLoadBalancerListenerDescription = struct {
    /// Information about the listener.
    listener: ?AwsElbLoadBalancerListener = null,

    /// The policies enabled for the listener.
    policy_names: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .listener = "Listener",
        .policy_names = "PolicyNames",
    };
};
