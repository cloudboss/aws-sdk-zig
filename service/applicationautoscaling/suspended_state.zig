/// Specifies whether the scaling activities for a scalable target are in a
/// suspended state.
pub const SuspendedState = struct {
    /// Whether scale in by a target tracking scaling policy or a step scaling
    /// policy is
    /// suspended. Set the value to `true` if you don't want Application Auto
    /// Scaling to remove capacity
    /// when a scaling policy is triggered. The default is `false`.
    dynamic_scaling_in_suspended: ?bool = null,

    /// Whether scale out by a target tracking scaling policy or a step scaling
    /// policy is
    /// suspended. Set the value to `true` if you don't want Application Auto
    /// Scaling to add capacity
    /// when a scaling policy is triggered. The default is `false`.
    dynamic_scaling_out_suspended: ?bool = null,

    /// Whether scheduled scaling is suspended. Set the value to `true` if you don't
    /// want Application Auto Scaling to add or remove capacity by initiating
    /// scheduled actions. The default is
    /// `false`.
    scheduled_scaling_suspended: ?bool = null,

    pub const json_field_names = .{
        .dynamic_scaling_in_suspended = "DynamicScalingInSuspended",
        .dynamic_scaling_out_suspended = "DynamicScalingOutSuspended",
        .scheduled_scaling_suspended = "ScheduledScalingSuspended",
    };
};
