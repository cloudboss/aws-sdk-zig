const AwsJobExponentialRolloutRate = @import("aws_job_exponential_rollout_rate.zig").AwsJobExponentialRolloutRate;

/// Configuration for the rollout of OTA updates.
pub const AwsJobExecutionsRolloutConfig = struct {
    /// The rate of increase for a job rollout. This parameter allows you to define
    /// an exponential rate
    /// increase for a job rollout.
    exponential_rate: ?AwsJobExponentialRolloutRate,

    /// The maximum number of OTA update job executions started per minute.
    maximum_per_minute: ?i32,

    pub const json_field_names = .{
        .exponential_rate = "exponentialRate",
        .maximum_per_minute = "maximumPerMinute",
    };
};
