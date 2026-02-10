const ClassicLoadBalancer = @import("classic_load_balancer.zig").ClassicLoadBalancer;

/// Describes the Classic Load Balancers to attach to a Spot Fleet. Spot Fleet
/// registers
/// the running Spot Instances with these Classic Load Balancers.
pub const ClassicLoadBalancersConfig = struct {
    /// One or more Classic Load Balancers.
    classic_load_balancers: ?[]const ClassicLoadBalancer,
};
