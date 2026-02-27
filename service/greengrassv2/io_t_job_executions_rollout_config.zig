const IoTJobExponentialRolloutRate = @import("io_t_job_exponential_rollout_rate.zig").IoTJobExponentialRolloutRate;

/// Contains information about the rollout configuration for a job. This
/// configuration defines
/// the rate at which the job deploys a configuration to a fleet of target
/// devices.
pub const IoTJobExecutionsRolloutConfig = struct {
    /// The exponential rate to increase the job rollout rate.
    exponential_rate: ?IoTJobExponentialRolloutRate,

    /// The maximum number of devices that receive a pending job notification, per
    /// minute.
    maximum_per_minute: ?i32,

    pub const json_field_names = .{
        .exponential_rate = "exponentialRate",
        .maximum_per_minute = "maximumPerMinute",
    };
};
