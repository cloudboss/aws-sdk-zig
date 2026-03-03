const ClassicLoadBalancersConfig = @import("classic_load_balancers_config.zig").ClassicLoadBalancersConfig;
const TargetGroupsConfig = @import("target_groups_config.zig").TargetGroupsConfig;

/// Describes the Classic Load Balancers and target groups to attach to a Spot
/// Fleet
/// request.
pub const LoadBalancersConfig = struct {
    /// The Classic Load Balancers.
    classic_load_balancers_config: ?ClassicLoadBalancersConfig = null,

    /// The target groups.
    target_groups_config: ?TargetGroupsConfig = null,
};
