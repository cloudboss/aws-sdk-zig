const ExponentialRolloutRate = @import("exponential_rollout_rate.zig").ExponentialRolloutRate;

/// Over-the-air (OTA) task rollout config.
pub const OtaTaskExecutionRolloutConfig = struct {
    /// Structure representing exponential rate of rollout for an over-the-air (OTA)
    /// task.
    exponential_rollout_rate: ?ExponentialRolloutRate,

    /// The maximum number of things that will be notified of a pending task, per
    /// minute.
    maximum_per_minute: ?i32,

    pub const json_field_names = .{
        .exponential_rollout_rate = "ExponentialRolloutRate",
        .maximum_per_minute = "MaximumPerMinute",
    };
};
