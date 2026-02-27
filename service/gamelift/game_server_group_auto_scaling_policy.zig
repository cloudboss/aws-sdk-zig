const TargetTrackingConfiguration = @import("target_tracking_configuration.zig").TargetTrackingConfiguration;

/// Configuration
/// settings for intelligent automatic scaling that uses target tracking. These
/// settings are
/// used to add an Auto Scaling policy when creating the corresponding Auto
/// Scaling group.
/// After the Auto Scaling group is created, all updates to Auto Scaling
/// policies, including
/// changing this policy and adding or removing other policies, is done directly
/// on the Auto
/// Scaling group.
pub const GameServerGroupAutoScalingPolicy = struct {
    /// Length of time, in seconds, it takes for a new instance to start new game
    /// server
    /// processes and register with Amazon GameLift Servers FleetIQ. Specifying a
    /// warm-up time can be useful, particularly
    /// with game servers that take a long time to start up, because it avoids
    /// prematurely
    /// starting new instances.
    estimated_instance_warmup: ?i32,

    /// Settings for a target-based scaling policy applied to Auto Scaling group.
    /// These
    /// settings are used to create a target-based policy that tracks the Amazon
    /// GameLift Servers FleetIQ metric
    /// `"PercentUtilizedGameServers"` and specifies a target value for the
    /// metric. As player usage changes, the policy triggers to adjust the game
    /// server group
    /// capacity so that the metric returns to the target value.
    target_tracking_configuration: TargetTrackingConfiguration,

    pub const json_field_names = .{
        .estimated_instance_warmup = "EstimatedInstanceWarmup",
        .target_tracking_configuration = "TargetTrackingConfiguration",
    };
};
