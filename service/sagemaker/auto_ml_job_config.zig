const AutoMLCandidateGenerationConfig = @import("auto_ml_candidate_generation_config.zig").AutoMLCandidateGenerationConfig;
const AutoMLJobCompletionCriteria = @import("auto_ml_job_completion_criteria.zig").AutoMLJobCompletionCriteria;
const AutoMLDataSplitConfig = @import("auto_ml_data_split_config.zig").AutoMLDataSplitConfig;
const AutoMLMode = @import("auto_ml_mode.zig").AutoMLMode;
const AutoMLSecurityConfig = @import("auto_ml_security_config.zig").AutoMLSecurityConfig;

/// A collection of settings used for an AutoML job.
pub const AutoMLJobConfig = struct {
    /// The configuration for generating a candidate for an AutoML job (optional).
    candidate_generation_config: ?AutoMLCandidateGenerationConfig,

    /// How long an AutoML job is allowed to run, or how many candidates a job is
    /// allowed to generate.
    completion_criteria: ?AutoMLJobCompletionCriteria,

    /// The configuration for splitting the input training dataset.
    ///
    /// Type: AutoMLDataSplitConfig
    data_split_config: ?AutoMLDataSplitConfig,

    /// The method that Autopilot uses to train the data. You can either specify the
    /// mode manually or let Autopilot choose for you based on the dataset size by
    /// selecting `AUTO`. In `AUTO` mode, Autopilot chooses `ENSEMBLING` for
    /// datasets smaller than 100 MB, and `HYPERPARAMETER_TUNING` for larger ones.
    ///
    /// The `ENSEMBLING` mode uses a multi-stack ensemble model to predict
    /// classification and regression tasks directly from your dataset. This machine
    /// learning mode combines several base models to produce an optimal predictive
    /// model. It then uses a stacking ensemble method to combine predictions from
    /// contributing members. A multi-stack ensemble model can provide better
    /// performance over a single model by combining the predictive capabilities of
    /// multiple models. See [Autopilot algorithm
    /// support](https://docs.aws.amazon.com/sagemaker/latest/dg/autopilot-model-support-validation.html#autopilot-algorithm-support) for a list of algorithms supported by `ENSEMBLING` mode.
    ///
    /// The `HYPERPARAMETER_TUNING` (HPO) mode uses the best hyperparameters to
    /// train the best version of a model. HPO automatically selects an algorithm
    /// for the type of problem you want to solve. Then HPO finds the best
    /// hyperparameters according to your objective metric. See [Autopilot algorithm
    /// support](https://docs.aws.amazon.com/sagemaker/latest/dg/autopilot-model-support-validation.html#autopilot-algorithm-support) for a list of algorithms supported by `HYPERPARAMETER_TUNING` mode.
    mode: ?AutoMLMode,

    /// The security configuration for traffic encryption or Amazon VPC settings.
    security_config: ?AutoMLSecurityConfig,

    pub const json_field_names = .{
        .candidate_generation_config = "CandidateGenerationConfig",
        .completion_criteria = "CompletionCriteria",
        .data_split_config = "DataSplitConfig",
        .mode = "Mode",
        .security_config = "SecurityConfig",
    };
};
