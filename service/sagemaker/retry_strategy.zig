/// The retry strategy to use when a training job fails due to an
/// `InternalServerError`. `RetryStrategy` is specified as part of the
/// `CreateTrainingJob` and `CreateHyperParameterTuningJob` requests. You can
/// add the `StoppingCondition` parameter to the request to limit the training
/// time for the complete job.
pub const RetryStrategy = struct {
    /// The number of times to retry the job. When the job is retried, it's
    /// `SecondaryStatus` is changed to `STARTING`.
    maximum_retry_attempts: i32,

    pub const json_field_names = .{
        .maximum_retry_attempts = "MaximumRetryAttempts",
    };
};
