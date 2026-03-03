const SecondaryStatus = @import("secondary_status.zig").SecondaryStatus;

/// An array element of `SecondaryStatusTransitions` for
/// [DescribeTrainingJob](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_DescribeTrainingJob.html). It provides additional details about a status that the training job has transitioned through. A training job can be in one of several states, for example, starting, downloading, training, or uploading. Within each state, there are a number of intermediate states. For example, within the starting state, SageMaker could be starting the training job or launching the ML instances. These transitional states are referred to as the job's secondary status.
pub const SecondaryStatusTransition = struct {
    /// A timestamp that shows when the training job transitioned out of this
    /// secondary status state into another secondary status state or when the
    /// training job has ended.
    end_time: ?i64 = null,

    /// A timestamp that shows when the training job transitioned to the current
    /// secondary status state.
    start_time: i64,

    /// Contains a secondary status information from a training job.
    ///
    /// Status might be one of the following secondary statuses:
    ///
    /// **InProgress**
    ///
    /// * `Starting` - Starting the training job.
    /// * `Downloading` - An optional stage for algorithms that support `File`
    ///   training input mode. It indicates that data is being downloaded to the ML
    ///   storage volumes.
    /// * `Training` - Training is in progress.
    /// * `Uploading` - Training is complete and the model artifacts are being
    ///   uploaded to the S3 location.
    ///
    /// **Completed**
    ///
    /// * `Completed` - The training job has completed.
    ///
    /// **Failed**
    ///
    /// * `Failed` - The training job has failed. The reason for the failure is
    ///   returned in the `FailureReason` field of `DescribeTrainingJobResponse`.
    ///
    /// **Stopped**
    ///
    /// * `MaxRuntimeExceeded` - The job stopped because it exceeded the maximum
    ///   allowed runtime.
    /// * `Stopped` - The training job has stopped.
    ///
    /// **Stopping**
    ///
    /// * `Stopping` - Stopping the training job.
    ///
    /// We no longer support the following secondary statuses:
    ///
    /// * `LaunchingMLInstances`
    /// * `PreparingTrainingStack`
    /// * `DownloadingTrainingImage`
    status: SecondaryStatus,

    /// A detailed description of the progress within a secondary status.
    ///
    /// SageMaker provides secondary statuses and status messages that apply to each
    /// of them:
    ///
    /// **Starting**
    ///
    /// * Starting the training job.
    /// * Launching requested ML instances.
    /// * Insufficient capacity error from EC2 while launching instances, retrying!
    /// * Launched instance was unhealthy, replacing it!
    /// * Preparing the instances for training.
    ///
    /// **Training**
    ///
    /// * Training image download completed. Training in progress.
    ///
    /// Status messages are subject to change. Therefore, we recommend not including
    /// them in code that programmatically initiates actions. For examples, don't
    /// use status messages in if statements.
    ///
    /// To have an overview of your training job's progress, view
    /// `TrainingJobStatus` and `SecondaryStatus` in
    /// [DescribeTrainingJob](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_DescribeTrainingJob.html), and `StatusMessage` together. For example, at the start of a training job, you might see the following:
    ///
    /// * `TrainingJobStatus` - InProgress
    /// * `SecondaryStatus` - Training
    /// * `StatusMessage` - Downloading the training image
    status_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .start_time = "StartTime",
        .status = "Status",
        .status_message = "StatusMessage",
    };
};
