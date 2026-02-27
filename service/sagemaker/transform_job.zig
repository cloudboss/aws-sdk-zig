const aws = @import("aws");

const BatchStrategy = @import("batch_strategy.zig").BatchStrategy;
const BatchDataCaptureConfig = @import("batch_data_capture_config.zig").BatchDataCaptureConfig;
const DataProcessing = @import("data_processing.zig").DataProcessing;
const ExperimentConfig = @import("experiment_config.zig").ExperimentConfig;
const ModelClientConfig = @import("model_client_config.zig").ModelClientConfig;
const Tag = @import("tag.zig").Tag;
const TransformInput = @import("transform_input.zig").TransformInput;
const TransformJobStatus = @import("transform_job_status.zig").TransformJobStatus;
const TransformOutput = @import("transform_output.zig").TransformOutput;
const TransformResources = @import("transform_resources.zig").TransformResources;

/// A batch transform job. For information about SageMaker batch transform, see
/// [Use Batch
/// Transform](https://docs.aws.amazon.com/sagemaker/latest/dg/batch-transform.html).
pub const TransformJob = struct {
    /// The Amazon Resource Name (ARN) of the AutoML job that created the transform
    /// job.
    auto_ml_job_arn: ?[]const u8,

    /// Specifies the number of records to include in a mini-batch for an HTTP
    /// inference request. A record is a single unit of input data that inference
    /// can be made on. For example, a single line in a CSV file is a record.
    batch_strategy: ?BatchStrategy,

    /// A timestamp that shows when the transform Job was created.
    creation_time: ?i64,

    data_capture_config: ?BatchDataCaptureConfig,

    data_processing: ?DataProcessing,

    /// The environment variables to set in the Docker container. We support up to
    /// 16 key and values entries in the map.
    environment: ?[]const aws.map.StringMapEntry,

    experiment_config: ?ExperimentConfig,

    /// If the transform job failed, the reason it failed.
    failure_reason: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the labeling job that created the
    /// transform job.
    labeling_job_arn: ?[]const u8,

    /// The maximum number of parallel requests that can be sent to each instance in
    /// a transform job. If `MaxConcurrentTransforms` is set to 0 or left unset,
    /// SageMaker checks the optional execution-parameters to determine the settings
    /// for your chosen algorithm. If the execution-parameters endpoint is not
    /// enabled, the default value is 1. For built-in algorithms, you don't need to
    /// set a value for `MaxConcurrentTransforms`.
    max_concurrent_transforms: ?i32,

    /// The maximum allowed size of the payload, in MB. A payload is the data
    /// portion of a record (without metadata). The value in `MaxPayloadInMB` must
    /// be greater than, or equal to, the size of a single record. To estimate the
    /// size of a record in MB, divide the size of your dataset by the number of
    /// records. To ensure that the records fit within the maximum payload size, we
    /// recommend using a slightly larger value. The default value is 6 MB. For
    /// cases where the payload might be arbitrarily large and is transmitted using
    /// HTTP chunked encoding, set the value to 0. This feature works only in
    /// supported algorithms. Currently, SageMaker built-in algorithms do not
    /// support HTTP chunked encoding.
    max_payload_in_mb: ?i32,

    model_client_config: ?ModelClientConfig,

    /// The name of the model associated with the transform job.
    model_name: ?[]const u8,

    /// A list of tags associated with the transform job.
    tags: ?[]const Tag,

    /// Indicates when the transform job has been completed, or has stopped or
    /// failed. You are billed for the time interval between this time and the value
    /// of `TransformStartTime`.
    transform_end_time: ?i64,

    transform_input: ?TransformInput,

    /// The Amazon Resource Name (ARN) of the transform job.
    transform_job_arn: ?[]const u8,

    /// The name of the transform job.
    transform_job_name: ?[]const u8,

    /// The status of the transform job.
    ///
    /// Transform job statuses are:
    ///
    /// * `InProgress` - The job is in progress.
    /// * `Completed` - The job has completed.
    /// * `Failed` - The transform job has failed. To see the reason for the
    ///   failure, see the `FailureReason` field in the response to a
    ///   `DescribeTransformJob` call.
    /// * `Stopping` - The transform job is stopping.
    /// * `Stopped` - The transform job has stopped.
    transform_job_status: ?TransformJobStatus,

    transform_output: ?TransformOutput,

    transform_resources: ?TransformResources,

    /// Indicates when the transform job starts on ML instances. You are billed for
    /// the time interval between this time and the value of `TransformEndTime`.
    transform_start_time: ?i64,

    pub const json_field_names = .{
        .auto_ml_job_arn = "AutoMLJobArn",
        .batch_strategy = "BatchStrategy",
        .creation_time = "CreationTime",
        .data_capture_config = "DataCaptureConfig",
        .data_processing = "DataProcessing",
        .environment = "Environment",
        .experiment_config = "ExperimentConfig",
        .failure_reason = "FailureReason",
        .labeling_job_arn = "LabelingJobArn",
        .max_concurrent_transforms = "MaxConcurrentTransforms",
        .max_payload_in_mb = "MaxPayloadInMB",
        .model_client_config = "ModelClientConfig",
        .model_name = "ModelName",
        .tags = "Tags",
        .transform_end_time = "TransformEndTime",
        .transform_input = "TransformInput",
        .transform_job_arn = "TransformJobArn",
        .transform_job_name = "TransformJobName",
        .transform_job_status = "TransformJobStatus",
        .transform_output = "TransformOutput",
        .transform_resources = "TransformResources",
        .transform_start_time = "TransformStartTime",
    };
};
