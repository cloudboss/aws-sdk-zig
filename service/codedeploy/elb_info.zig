/// Information about a Classic Load Balancer in Elastic Load Balancing to use
/// in a
/// deployment. Instances are registered directly with a load balancer, and
/// traffic is
/// routed to the load balancer.
pub const ELBInfo = struct {
    /// For blue/green deployments, the name of the Classic Load Balancer that is
    /// used to
    /// route traffic from original instances to replacement instances in a
    /// blue/green
    /// deployment. For in-place deployments, the name of the Classic Load Balancer
    /// that
    /// instances are deregistered from so they are not serving traffic during a
    /// deployment, and
    /// then re-registered with after the deployment is complete.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "name",
    };
};
