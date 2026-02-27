const RateIncreaseCriteria = @import("rate_increase_criteria.zig").RateIncreaseCriteria;

/// Allows you to create an exponential rate of rollout for a job.
pub const ExponentialRolloutRate = struct {
    /// The minimum number of things that will be notified of a pending job, per
    /// minute at
    /// the start of job rollout. This parameter allows you to define the initial
    /// rate of
    /// rollout.
    base_rate_per_minute: i32,

    /// The exponential factor to increase the rate of rollout for a job.
    ///
    /// Amazon Web Services IoT Core supports up to one digit after the decimal (for
    /// example, 1.5, but not
    /// 1.55).
    increment_factor: f64,

    /// The criteria to initiate the increase in rate of rollout for a job.
    rate_increase_criteria: RateIncreaseCriteria,

    pub const json_field_names = .{
        .base_rate_per_minute = "baseRatePerMinute",
        .increment_factor = "incrementFactor",
        .rate_increase_criteria = "rateIncreaseCriteria",
    };
};
