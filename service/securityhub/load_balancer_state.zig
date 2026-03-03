/// Information about the state of the load balancer.
pub const LoadBalancerState = struct {
    /// The state code. The initial state of the load balancer is provisioning.
    ///
    /// After the load balancer is fully set up and ready to route traffic, its
    /// state is
    /// active.
    ///
    /// If the load balancer could not be set up, its state is failed.
    code: ?[]const u8 = null,

    /// A description of the state.
    reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .reason = "Reason",
    };
};
