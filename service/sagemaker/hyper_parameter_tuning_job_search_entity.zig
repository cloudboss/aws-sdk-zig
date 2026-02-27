const HyperParameterTrainingJobSummary = @import("hyper_parameter_training_job_summary.zig").HyperParameterTrainingJobSummary;
const HyperParameterTuningJobConsumedResources = @import("hyper_parameter_tuning_job_consumed_resources.zig").HyperParameterTuningJobConsumedResources;
const HyperParameterTuningJobConfig = @import("hyper_parameter_tuning_job_config.zig").HyperParameterTuningJobConfig;
const HyperParameterTuningJobStatus = @import("hyper_parameter_tuning_job_status.zig").HyperParameterTuningJobStatus;
const ObjectiveStatusCounters = @import("objective_status_counters.zig").ObjectiveStatusCounters;
const Tag = @import("tag.zig").Tag;
const HyperParameterTrainingJobDefinition = @import("hyper_parameter_training_job_definition.zig").HyperParameterTrainingJobDefinition;
const TrainingJobStatusCounters = @import("training_job_status_counters.zig").TrainingJobStatusCounters;
const HyperParameterTuningJobCompletionDetails = @import("hyper_parameter_tuning_job_completion_details.zig").HyperParameterTuningJobCompletionDetails;
const HyperParameterTuningJobWarmStartConfig = @import("hyper_parameter_tuning_job_warm_start_config.zig").HyperParameterTuningJobWarmStartConfig;

/// An entity returned by the
/// [SearchRecord](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_SearchRecord.html) API containing the properties of a hyperparameter tuning job.
pub const HyperParameterTuningJobSearchEntity = struct {
    best_training_job: ?HyperParameterTrainingJobSummary,

    /// The total amount of resources consumed by a hyperparameter tuning job.
    consumed_resources: ?HyperParameterTuningJobConsumedResources,

    /// The time that a hyperparameter tuning job was created.
    creation_time: ?i64,

    /// The error that was created when a hyperparameter tuning job failed.
    failure_reason: ?[]const u8,

    /// The time that a hyperparameter tuning job ended.
    hyper_parameter_tuning_end_time: ?i64,

    /// The Amazon Resource Name (ARN) of a hyperparameter tuning job.
    hyper_parameter_tuning_job_arn: ?[]const u8,

    hyper_parameter_tuning_job_config: ?HyperParameterTuningJobConfig,

    /// The name of a hyperparameter tuning job.
    hyper_parameter_tuning_job_name: ?[]const u8,

    /// The status of a hyperparameter tuning job.
    hyper_parameter_tuning_job_status: ?HyperParameterTuningJobStatus,

    /// The time that a hyperparameter tuning job was last modified.
    last_modified_time: ?i64,

    objective_status_counters: ?ObjectiveStatusCounters,

    overall_best_training_job: ?HyperParameterTrainingJobSummary,

    /// The tags associated with a hyperparameter tuning job. For more information
    /// see [Tagging Amazon Web Services
    /// resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html).
    tags: ?[]const Tag,

    training_job_definition: ?HyperParameterTrainingJobDefinition,

    /// The job definitions included in a hyperparameter tuning job.
    training_job_definitions: ?[]const HyperParameterTrainingJobDefinition,

    training_job_status_counters: ?TrainingJobStatusCounters,

    /// Information about either a current or completed hyperparameter tuning job.
    tuning_job_completion_details: ?HyperParameterTuningJobCompletionDetails,

    warm_start_config: ?HyperParameterTuningJobWarmStartConfig,

    pub const json_field_names = .{
        .best_training_job = "BestTrainingJob",
        .consumed_resources = "ConsumedResources",
        .creation_time = "CreationTime",
        .failure_reason = "FailureReason",
        .hyper_parameter_tuning_end_time = "HyperParameterTuningEndTime",
        .hyper_parameter_tuning_job_arn = "HyperParameterTuningJobArn",
        .hyper_parameter_tuning_job_config = "HyperParameterTuningJobConfig",
        .hyper_parameter_tuning_job_name = "HyperParameterTuningJobName",
        .hyper_parameter_tuning_job_status = "HyperParameterTuningJobStatus",
        .last_modified_time = "LastModifiedTime",
        .objective_status_counters = "ObjectiveStatusCounters",
        .overall_best_training_job = "OverallBestTrainingJob",
        .tags = "Tags",
        .training_job_definition = "TrainingJobDefinition",
        .training_job_definitions = "TrainingJobDefinitions",
        .training_job_status_counters = "TrainingJobStatusCounters",
        .tuning_job_completion_details = "TuningJobCompletionDetails",
        .warm_start_config = "WarmStartConfig",
    };
};
