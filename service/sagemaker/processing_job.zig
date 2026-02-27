const aws = @import("aws");

const AppSpecification = @import("app_specification.zig").AppSpecification;
const ExperimentConfig = @import("experiment_config.zig").ExperimentConfig;
const NetworkConfig = @import("network_config.zig").NetworkConfig;
const ProcessingInput = @import("processing_input.zig").ProcessingInput;
const ProcessingJobStatus = @import("processing_job_status.zig").ProcessingJobStatus;
const ProcessingOutputConfig = @import("processing_output_config.zig").ProcessingOutputConfig;
const ProcessingResources = @import("processing_resources.zig").ProcessingResources;
const ProcessingStoppingCondition = @import("processing_stopping_condition.zig").ProcessingStoppingCondition;
const Tag = @import("tag.zig").Tag;

/// An Amazon SageMaker processing job that is used to analyze data and evaluate
/// models. For more information, see [Process Data and Evaluate
/// Models](https://docs.aws.amazon.com/sagemaker/latest/dg/processing-job.html).
pub const ProcessingJob = struct {
    app_specification: ?AppSpecification,

    /// The Amazon Resource Name (ARN) of the AutoML job associated with this
    /// processing job.
    auto_ml_job_arn: ?[]const u8,

    /// The time the processing job was created.
    creation_time: ?i64,

    /// Sets the environment variables in the Docker container.
    environment: ?[]const aws.map.StringMapEntry,

    /// A string, up to one KB in size, that contains metadata from the processing
    /// container when the processing job exits.
    exit_message: ?[]const u8,

    experiment_config: ?ExperimentConfig,

    /// A string, up to one KB in size, that contains the reason a processing job
    /// failed, if it failed.
    failure_reason: ?[]const u8,

    /// The time the processing job was last modified.
    last_modified_time: ?i64,

    /// The ARN of a monitoring schedule for an endpoint associated with this
    /// processing job.
    monitoring_schedule_arn: ?[]const u8,

    network_config: ?NetworkConfig,

    /// The time that the processing job ended.
    processing_end_time: ?i64,

    /// List of input configurations for the processing job.
    processing_inputs: ?[]const ProcessingInput,

    /// The ARN of the processing job.
    processing_job_arn: ?[]const u8,

    /// The name of the processing job.
    processing_job_name: ?[]const u8,

    /// The status of the processing job.
    processing_job_status: ?ProcessingJobStatus,

    processing_output_config: ?ProcessingOutputConfig,

    processing_resources: ?ProcessingResources,

    /// The time that the processing job started.
    processing_start_time: ?i64,

    /// The ARN of the role used to create the processing job.
    role_arn: ?[]const u8,

    stopping_condition: ?ProcessingStoppingCondition,

    /// An array of key-value pairs. For more information, see [Using Cost
    /// Allocation
    /// Tags](https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/cost-alloc-tags.html#allocation-whatURL) in the *Amazon Web Services Billing and Cost Management User Guide*.
    tags: ?[]const Tag,

    /// The ARN of the training job associated with this processing job.
    training_job_arn: ?[]const u8,

    pub const json_field_names = .{
        .app_specification = "AppSpecification",
        .auto_ml_job_arn = "AutoMLJobArn",
        .creation_time = "CreationTime",
        .environment = "Environment",
        .exit_message = "ExitMessage",
        .experiment_config = "ExperimentConfig",
        .failure_reason = "FailureReason",
        .last_modified_time = "LastModifiedTime",
        .monitoring_schedule_arn = "MonitoringScheduleArn",
        .network_config = "NetworkConfig",
        .processing_end_time = "ProcessingEndTime",
        .processing_inputs = "ProcessingInputs",
        .processing_job_arn = "ProcessingJobArn",
        .processing_job_name = "ProcessingJobName",
        .processing_job_status = "ProcessingJobStatus",
        .processing_output_config = "ProcessingOutputConfig",
        .processing_resources = "ProcessingResources",
        .processing_start_time = "ProcessingStartTime",
        .role_arn = "RoleArn",
        .stopping_condition = "StoppingCondition",
        .tags = "Tags",
        .training_job_arn = "TrainingJobArn",
    };
};
