/// Describes the state of a target group.
pub const LoadBalancerTargetGroupState = struct {
    /// The Amazon Resource Name (ARN) of the target group.
    load_balancer_target_group_arn: ?[]const u8,

    /// The state of the target group.
    ///
    /// * `Adding` - The Auto Scaling instances are being registered with the target
    /// group.
    ///
    /// * `Added` - All Auto Scaling instances are registered with the target
    /// group.
    ///
    /// * `InService` - At least one Auto Scaling instance passed an `ELB`
    /// health check.
    ///
    /// * `Removing` - The Auto Scaling instances are being deregistered from the
    /// target group. If connection draining is enabled, Elastic Load Balancing
    /// waits for in-flight
    /// requests to complete before deregistering the instances.
    ///
    /// * `Removed` - All Auto Scaling instances are deregistered from the target
    /// group.
    state: ?[]const u8,
};
