const AwsJobRateIncreaseCriteria = @import("aws_job_rate_increase_criteria.zig").AwsJobRateIncreaseCriteria;

/// The rate of increase for a job rollout. This parameter allows you to define
/// an exponential rate
/// increase for a job rollout.
pub const AwsJobExponentialRolloutRate = struct {
    /// The minimum number of things that will be notified of a pending job, per
    /// minute, at the start
    /// of the job rollout. This is the initial rate of the rollout.
    base_rate_per_minute: i32,

    /// The rate of increase for a job rollout. The number of things notified is
    /// multiplied by this
    /// factor.
    increment_factor: f64 = 0,

    /// The criteria to initiate the increase in rate of rollout for a job.
    ///
    /// Amazon Web Services IoT Core supports up to one digit after the decimal (for
    /// example, 1.5, but not 1.55).
    rate_increase_criteria: AwsJobRateIncreaseCriteria,

    pub const json_field_names = .{
        .base_rate_per_minute = "baseRatePerMinute",
        .increment_factor = "incrementFactor",
        .rate_increase_criteria = "rateIncreaseCriteria",
    };
};
