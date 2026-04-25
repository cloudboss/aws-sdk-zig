/// An object that represents a scaling policy for a compute environment.
pub const ComputeScalingPolicy = struct {
    /// The minimum time (in minutes) that Batch keeps instances running in the
    /// compute environment
    /// after their jobs complete. For each instance, the delay period begins when
    /// the last job finishes.
    /// If no new jobs are placed on the instance during this delay, Batch
    /// terminates the instance once
    /// the delay expires.
    ///
    /// Valid Range: Minimum value of 20. Maximum value of 10080. Use 0 to unset and
    /// disable the scale down delay.
    ///
    /// The scale down delay does not apply to:
    ///
    /// * Instances being replaced during infrastructure updates
    ///
    /// * Newly launched instances that have not yet run any jobs
    ///
    /// * Spot instances reclaimed due to interruption
    min_scale_down_delay_minutes: ?i32 = null,

    pub const json_field_names = .{
        .min_scale_down_delay_minutes = "minScaleDownDelayMinutes",
    };
};
