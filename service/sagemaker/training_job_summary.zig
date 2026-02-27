const SecondaryStatus = @import("secondary_status.zig").SecondaryStatus;
const TrainingJobStatus = @import("training_job_status.zig").TrainingJobStatus;
const WarmPoolStatus = @import("warm_pool_status.zig").WarmPoolStatus;

/// Provides summary information about a training job.
pub const TrainingJobSummary = struct {
    /// A timestamp that shows when the training job was created.
    creation_time: i64,

    /// Timestamp when the training job was last modified.
    last_modified_time: ?i64,

    /// The secondary status of the training job.
    secondary_status: ?SecondaryStatus,

    /// A timestamp that shows when the training job ended. This field is set only
    /// if the training job has one of the terminal statuses (`Completed`, `Failed`,
    /// or `Stopped`).
    training_end_time: ?i64,

    /// The Amazon Resource Name (ARN) of the training job.
    training_job_arn: []const u8,

    /// The name of the training job that you want a summary for.
    training_job_name: []const u8,

    /// The status of the training job.
    training_job_status: TrainingJobStatus,

    /// The Amazon Resource Name (ARN); of the training plan associated with this
    /// training job.
    ///
    /// For more information about how to reserve GPU capacity for your SageMaker
    /// HyperPod clusters using Amazon SageMaker Training Plan, see `
    /// [CreateTrainingPlan](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateTrainingPlan.html) `.
    training_plan_arn: ?[]const u8,

    /// The status of the warm pool associated with the training job.
    warm_pool_status: ?WarmPoolStatus,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .last_modified_time = "LastModifiedTime",
        .secondary_status = "SecondaryStatus",
        .training_end_time = "TrainingEndTime",
        .training_job_arn = "TrainingJobArn",
        .training_job_name = "TrainingJobName",
        .training_job_status = "TrainingJobStatus",
        .training_plan_arn = "TrainingPlanArn",
        .warm_pool_status = "WarmPoolStatus",
    };
};
