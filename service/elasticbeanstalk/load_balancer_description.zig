const Listener = @import("listener.zig").Listener;

/// Describes the details of a LoadBalancer.
pub const LoadBalancerDescription = struct {
    /// The domain name of the LoadBalancer.
    domain: ?[]const u8 = null,

    /// A list of Listeners used by the LoadBalancer.
    listeners: ?[]const Listener = null,

    /// The name of the LoadBalancer.
    load_balancer_name: ?[]const u8 = null,
};
