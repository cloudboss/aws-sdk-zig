/// Settings for a target-based scaling policy. A target-based policy tracks a
/// particular
/// fleet metric specifies a target value for the metric. As player usage
/// changes, the
/// policy triggers Amazon GameLift Servers to adjust capacity so that the
/// metric returns to the target
/// value. The target configuration specifies settings as needed for the target
/// based
/// policy, including the target value.
pub const TargetConfiguration = struct {
    /// Desired value to use with a target-based scaling policy. The value must be
    /// relevant
    /// for whatever metric the scaling policy is using. For example, in a policy
    /// using the
    /// metric PercentAvailableGameSessions, the target value should be the
    /// preferred size of
    /// the fleet's buffer (the percent of capacity that should be idle and ready
    /// for new game
    /// sessions).
    target_value: f64,

    pub const json_field_names = .{
        .target_value = "TargetValue",
    };
};
