const aws = @import("aws");

const FinalHyperParameterTuningJobObjectiveMetric = @import("final_hyper_parameter_tuning_job_objective_metric.zig").FinalHyperParameterTuningJobObjectiveMetric;
const ObjectiveStatus = @import("objective_status.zig").ObjectiveStatus;
const TrainingJobStatus = @import("training_job_status.zig").TrainingJobStatus;

/// The container for the summary information about a training job.
pub const HyperParameterTrainingJobSummary = struct {
    /// The date and time that the training job was created.
    creation_time: i64,

    /// The reason that the training job failed.
    failure_reason: ?[]const u8,

    /// The
    /// [FinalHyperParameterTuningJobObjectiveMetric](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_FinalHyperParameterTuningJobObjectiveMetric.html) object that specifies the value of the objective metric of the tuning job that launched this training job.
    final_hyper_parameter_tuning_job_objective_metric: ?FinalHyperParameterTuningJobObjectiveMetric,

    /// The status of the objective metric for the training job:
    ///
    /// * Succeeded: The final objective metric for the training job was evaluated
    ///   by the hyperparameter tuning job and used in the hyperparameter tuning
    ///   process.
    ///
    /// * Pending: The training job is in progress and evaluation of its final
    ///   objective metric is pending.
    ///
    /// * Failed: The final objective metric for the training job was not evaluated,
    ///   and was not used in the hyperparameter tuning process. This typically
    ///   occurs when the training job failed or did not emit an objective metric.
    objective_status: ?ObjectiveStatus,

    /// Specifies the time when the training job ends on training instances. You are
    /// billed for the time interval between the value of `TrainingStartTime` and
    /// this time. For successful jobs and stopped jobs, this is the time after
    /// model artifacts are uploaded. For failed jobs, this is the time when
    /// SageMaker detects a job failure.
    training_end_time: ?i64,

    /// The Amazon Resource Name (ARN) of the training job.
    training_job_arn: []const u8,

    /// The training job definition name.
    training_job_definition_name: ?[]const u8,

    /// The name of the training job.
    training_job_name: []const u8,

    /// The status of the training job.
    training_job_status: TrainingJobStatus,

    /// The date and time that the training job started.
    training_start_time: ?i64,

    /// A list of the hyperparameters for which you specified ranges to search.
    tuned_hyper_parameters: []const aws.map.StringMapEntry,

    /// The HyperParameter tuning job that launched the training job.
    tuning_job_name: ?[]const u8,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .failure_reason = "FailureReason",
        .final_hyper_parameter_tuning_job_objective_metric = "FinalHyperParameterTuningJobObjectiveMetric",
        .objective_status = "ObjectiveStatus",
        .training_end_time = "TrainingEndTime",
        .training_job_arn = "TrainingJobArn",
        .training_job_definition_name = "TrainingJobDefinitionName",
        .training_job_name = "TrainingJobName",
        .training_job_status = "TrainingJobStatus",
        .training_start_time = "TrainingStartTime",
        .tuned_hyper_parameters = "TunedHyperParameters",
        .tuning_job_name = "TuningJobName",
    };
};
