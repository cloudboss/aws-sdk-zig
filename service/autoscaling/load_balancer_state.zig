/// Describes the state of a Classic Load Balancer.
pub const LoadBalancerState = struct {
    /// The name of the load balancer.
    load_balancer_name: ?[]const u8,

    /// One of the following load balancer states:
    ///
    /// * `Adding` - The Auto Scaling instances are being registered with the load
    /// balancer.
    ///
    /// * `Added` - All Auto Scaling instances are registered with the load
    /// balancer.
    ///
    /// * `InService` - At least one Auto Scaling instance passed an `ELB`
    /// health check.
    ///
    /// * `Removing` - The Auto Scaling instances are being deregistered from the
    /// load balancer. If connection draining is enabled, Elastic Load Balancing
    /// waits for in-flight
    /// requests to complete before deregistering the instances.
    ///
    /// * `Removed` - All Auto Scaling instances are deregistered from the load
    /// balancer.
    state: ?[]const u8,
};
