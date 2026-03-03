/// How long a job is allowed to run, or how many candidates a job is allowed to
/// generate.
pub const AutoMLJobCompletionCriteria = struct {
    /// The maximum runtime, in seconds, an AutoML job has to complete.
    ///
    /// If an AutoML job exceeds the maximum runtime, the job is stopped
    /// automatically and its processing is ended gracefully. The AutoML job
    /// identifies the best model whose training was completed and marks it as the
    /// best-performing model. Any unfinished steps of the job, such as automatic
    /// one-click Autopilot model deployment, are not completed.
    max_auto_ml_job_runtime_in_seconds: ?i32 = null,

    /// The maximum number of times a training job is allowed to run.
    ///
    /// For text and image classification, time-series forecasting, as well as text
    /// generation (LLMs fine-tuning) problem types, the supported value is 1. For
    /// tabular problem types, the maximum value is 750.
    max_candidates: ?i32 = null,

    /// The maximum time, in seconds, that each training job executed inside
    /// hyperparameter tuning is allowed to run as part of a hyperparameter tuning
    /// job. For more information, see the
    /// [StoppingCondition](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_StoppingCondition.html) used by the [CreateHyperParameterTuningJob](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateHyperParameterTuningJob.html) action.
    ///
    /// For job V2s (jobs created by calling `CreateAutoMLJobV2`), this field
    /// controls the runtime of the job candidate.
    ///
    /// For
    /// [TextGenerationJobConfig](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_TextClassificationJobConfig.html) problem types, the maximum time defaults to 72 hours (259200 seconds).
    max_runtime_per_training_job_in_seconds: ?i32 = null,

    pub const json_field_names = .{
        .max_auto_ml_job_runtime_in_seconds = "MaxAutoMLJobRuntimeInSeconds",
        .max_candidates = "MaxCandidates",
        .max_runtime_per_training_job_in_seconds = "MaxRuntimePerTrainingJobInSeconds",
    };
};
