const ExponentialRolloutRate = @import("exponential_rollout_rate.zig").ExponentialRolloutRate;

/// Allows you to create a staged rollout of a job.
pub const JobExecutionsRolloutConfig = struct {
    /// The rate of increase for a job rollout. This parameter allows you to define
    /// an
    /// exponential rate for a job rollout.
    exponential_rate: ?ExponentialRolloutRate,

    /// The maximum number of things that will be notified of a pending job, per
    /// minute.
    /// This parameter allows you to create a staged rollout.
    maximum_per_minute: ?i32,

    pub const json_field_names = .{
        .exponential_rate = "exponentialRate",
        .maximum_per_minute = "maximumPerMinute",
    };
};
