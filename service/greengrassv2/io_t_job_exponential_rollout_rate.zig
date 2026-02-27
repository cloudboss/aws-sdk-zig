const IoTJobRateIncreaseCriteria = @import("io_t_job_rate_increase_criteria.zig").IoTJobRateIncreaseCriteria;

/// Contains information about an exponential rollout rate for a configuration
/// deployment
/// job.
pub const IoTJobExponentialRolloutRate = struct {
    /// The minimum number of devices that receive a pending job notification, per
    /// minute, when
    /// the job starts. This parameter defines the initial rollout rate of the job.
    base_rate_per_minute: i32,

    /// The exponential factor to increase the rollout rate for the job.
    ///
    /// This parameter supports up to one digit after the decimal (for example, you
    /// can specify
    /// `1.5`, but not `1.55`).
    increment_factor: f64,

    /// The criteria to increase the rollout rate for the job.
    rate_increase_criteria: IoTJobRateIncreaseCriteria,

    pub const json_field_names = .{
        .base_rate_per_minute = "baseRatePerMinute",
        .increment_factor = "incrementFactor",
        .rate_increase_criteria = "rateIncreaseCriteria",
    };
};
