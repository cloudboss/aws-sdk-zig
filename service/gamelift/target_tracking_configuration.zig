/// Settings for a
/// target-based scaling policy as part of a
/// [GameServerGroupAutoScalingPolicy](https://docs.aws.amazon.com/gamelift/latest/apireference/API_GameServerGroupAutoScalingPolicy.html) . These settings are used to create a
/// target-based policy that tracks the Amazon GameLift Servers FleetIQ metric
/// `"PercentUtilizedGameServers"` and specifies a target value for the
/// metric. As player usage changes, the policy triggers to adjust the game
/// server group
/// capacity so that the metric returns to the target value.
pub const TargetTrackingConfiguration = struct {
    /// Desired value to use with a game server group target-based scaling policy.
    target_value: f64,

    pub const json_field_names = .{
        .target_value = "TargetValue",
    };
};
