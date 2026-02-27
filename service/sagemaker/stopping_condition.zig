/// Specifies a limit to how long a job can run. When the job reaches the time
/// limit, SageMaker ends the job. Use this API to cap costs.
///
/// To stop a training job, SageMaker sends the algorithm the `SIGTERM` signal,
/// which delays job termination for 120 seconds. Algorithms can use this
/// 120-second window to save the model artifacts, so the results of training
/// are not lost.
///
/// The training algorithms provided by SageMaker automatically save the
/// intermediate results of a model training job when possible. This attempt to
/// save artifacts is only a best effort case as model might not be in a state
/// from which it can be saved. For example, if training has just started, the
/// model might not be ready to save. When saved, this intermediate data is a
/// valid model artifact. You can use it to create a model with `CreateModel`.
///
/// The Neural Topic Model (NTM) currently does not support saving intermediate
/// model artifacts. When training NTMs, make sure that the maximum runtime is
/// sufficient for the training job to complete.
pub const StoppingCondition = struct {
    /// The maximum length of time, in seconds, that a training or compilation job
    /// can be pending before it is stopped.
    ///
    /// When working with training jobs that use capacity from [training
    /// plans](https://docs.aws.amazon.com/sagemaker/latest/dg/reserve-capacity-with-training-plans.html), not all `Pending` job states count against the `MaxPendingTimeInSeconds` limit. The following scenarios do not increment the `MaxPendingTimeInSeconds` counter:
    ///
    /// * The plan is in a `Scheduled` state: Jobs queued (in `Pending` status)
    ///   before a plan's start date (waiting for scheduled start time)
    /// * Between capacity reservations: Jobs temporarily back to `Pending` status
    ///   between two capacity reservation periods
    ///
    /// `MaxPendingTimeInSeconds` only increments when jobs are actively waiting for
    /// capacity in an `Active` plan.
    max_pending_time_in_seconds: ?i32,

    /// The maximum length of time, in seconds, that a training or compilation job
    /// can run before it is stopped.
    ///
    /// For compilation jobs, if the job does not complete during this time, a
    /// `TimeOut` error is generated. We recommend starting with 900 seconds and
    /// increasing as necessary based on your model.
    ///
    /// For all other jobs, if the job does not complete during this time, SageMaker
    /// ends the job. When `RetryStrategy` is specified in the job request,
    /// `MaxRuntimeInSeconds` specifies the maximum time for all of the attempts in
    /// total, not each individual attempt. The default value is 1 day. The maximum
    /// value is 28 days.
    ///
    /// The maximum time that a `TrainingJob` can run in total, including any time
    /// spent publishing metrics or archiving and uploading models after it has been
    /// stopped, is 30 days.
    max_runtime_in_seconds: ?i32,

    /// The maximum length of time, in seconds, that a managed Spot training job has
    /// to complete. It is the amount of time spent waiting for Spot capacity plus
    /// the amount of time the job can run. It must be equal to or greater than
    /// `MaxRuntimeInSeconds`. If the job does not complete during this time,
    /// SageMaker ends the job.
    ///
    /// When `RetryStrategy` is specified in the job request, `MaxWaitTimeInSeconds`
    /// specifies the maximum time for all of the attempts in total, not each
    /// individual attempt.
    max_wait_time_in_seconds: ?i32,

    pub const json_field_names = .{
        .max_pending_time_in_seconds = "MaxPendingTimeInSeconds",
        .max_runtime_in_seconds = "MaxRuntimeInSeconds",
        .max_wait_time_in_seconds = "MaxWaitTimeInSeconds",
    };
};
