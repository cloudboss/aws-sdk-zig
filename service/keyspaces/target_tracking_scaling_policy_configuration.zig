/// The auto scaling policy that scales a table based on the ratio of consumed
/// to provisioned capacity.
pub const TargetTrackingScalingPolicyConfiguration = struct {
    /// Specifies if `scale-in` is enabled.
    ///
    /// When auto scaling automatically decreases capacity for a table, the table
    /// *scales in*. When scaling policies are set, they can't scale in the table
    /// lower than its minimum capacity.
    disable_scale_in: bool = false,

    /// Specifies a `scale-in` cool down period.
    ///
    /// A cooldown period in seconds between scaling activities that lets the table
    /// stabilize before another scaling activity starts.
    scale_in_cooldown: i32 = 0,

    /// Specifies a scale out cool down period.
    ///
    /// A cooldown period in seconds between scaling activities that lets the table
    /// stabilize before another scaling activity starts.
    scale_out_cooldown: i32 = 0,

    /// Specifies the target value for the target tracking auto scaling policy.
    ///
    /// Amazon Keyspaces auto scaling scales up capacity automatically when traffic
    /// exceeds this target utilization rate, and then back down when it falls below
    /// the target. This ensures that the ratio of consumed capacity to provisioned
    /// capacity stays at or near this value. You define `targetValue` as a
    /// percentage. A `double` between 20 and 90.
    target_value: f64 = 0,

    pub const json_field_names = .{
        .disable_scale_in = "disableScaleIn",
        .scale_in_cooldown = "scaleInCooldown",
        .scale_out_cooldown = "scaleOutCooldown",
        .target_value = "targetValue",
    };
};
