const HyperParameterTuningJobStatus = @import("hyper_parameter_tuning_job_status.zig").HyperParameterTuningJobStatus;
const ObjectiveStatusCounters = @import("objective_status_counters.zig").ObjectiveStatusCounters;
const ResourceLimits = @import("resource_limits.zig").ResourceLimits;
const HyperParameterTuningJobStrategyType = @import("hyper_parameter_tuning_job_strategy_type.zig").HyperParameterTuningJobStrategyType;
const TrainingJobStatusCounters = @import("training_job_status_counters.zig").TrainingJobStatusCounters;

/// Provides summary information about a hyperparameter tuning job.
pub const HyperParameterTuningJobSummary = struct {
    /// The date and time that the tuning job was created.
    creation_time: i64,

    /// The date and time that the tuning job ended.
    hyper_parameter_tuning_end_time: ?i64,

    /// The Amazon Resource Name (ARN) of the tuning job.
    hyper_parameter_tuning_job_arn: []const u8,

    /// The name of the tuning job.
    hyper_parameter_tuning_job_name: []const u8,

    /// The status of the tuning job.
    hyper_parameter_tuning_job_status: HyperParameterTuningJobStatus,

    /// The date and time that the tuning job was modified.
    last_modified_time: ?i64,

    /// The
    /// [ObjectiveStatusCounters](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_ObjectiveStatusCounters.html) object that specifies the numbers of training jobs, categorized by objective metric status, that this tuning job launched.
    objective_status_counters: ObjectiveStatusCounters,

    /// The
    /// [ResourceLimits](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_ResourceLimits.html) object that specifies the maximum number of training jobs and parallel training jobs allowed for this tuning job.
    resource_limits: ?ResourceLimits,

    /// Specifies the search strategy hyperparameter tuning uses to choose which
    /// hyperparameters to evaluate at each iteration.
    strategy: HyperParameterTuningJobStrategyType,

    /// The
    /// [TrainingJobStatusCounters](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_TrainingJobStatusCounters.html) object that specifies the numbers of training jobs, categorized by status, that this tuning job launched.
    training_job_status_counters: TrainingJobStatusCounters,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .hyper_parameter_tuning_end_time = "HyperParameterTuningEndTime",
        .hyper_parameter_tuning_job_arn = "HyperParameterTuningJobArn",
        .hyper_parameter_tuning_job_name = "HyperParameterTuningJobName",
        .hyper_parameter_tuning_job_status = "HyperParameterTuningJobStatus",
        .last_modified_time = "LastModifiedTime",
        .objective_status_counters = "ObjectiveStatusCounters",
        .resource_limits = "ResourceLimits",
        .strategy = "Strategy",
        .training_job_status_counters = "TrainingJobStatusCounters",
    };
};
