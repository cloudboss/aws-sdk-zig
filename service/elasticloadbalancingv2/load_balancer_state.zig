const LoadBalancerStateEnum = @import("load_balancer_state_enum.zig").LoadBalancerStateEnum;

/// Information about the state of the load balancer.
pub const LoadBalancerState = struct {
    /// The state code. The initial state of the load balancer is `provisioning`.
    /// After
    /// the load balancer is fully set up and ready to route traffic, its state is
    /// `active`. If load balancer is routing traffic but does not have the
    /// resources it
    /// needs to scale, its state is`active_impaired`. If the load balancer could
    /// not be
    /// set up, its state is `failed`.
    code: ?LoadBalancerStateEnum,

    /// A description of the state.
    reason: ?[]const u8,
};
