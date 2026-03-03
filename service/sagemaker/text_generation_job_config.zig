const aws = @import("aws");

const AutoMLJobCompletionCriteria = @import("auto_ml_job_completion_criteria.zig").AutoMLJobCompletionCriteria;
const ModelAccessConfig = @import("model_access_config.zig").ModelAccessConfig;

/// The collection of settings used by an AutoML job V2 for the text generation
/// problem type.
///
/// The text generation models that support fine-tuning in Autopilot are
/// currently accessible exclusively in regions supported by Canvas. Refer to
/// the documentation of Canvas for the [full list of its supported
/// Regions](https://docs.aws.amazon.com/sagemaker/latest/dg/canvas.html).
pub const TextGenerationJobConfig = struct {
    /// The name of the base model to fine-tune. Autopilot supports fine-tuning a
    /// variety of large language models. For information on the list of supported
    /// models, see [Text generation models supporting fine-tuning in
    /// Autopilot](https://docs.aws.amazon.com/sagemaker/latest/dg/autopilot-llms-finetuning-models.html#autopilot-llms-finetuning-supported-llms). If no `BaseModelName` is provided, the default model used is **Falcon7BInstruct**.
    base_model_name: ?[]const u8 = null,

    /// How long a fine-tuning job is allowed to run. For `TextGenerationJobConfig`
    /// problem types, the `MaxRuntimePerTrainingJobInSeconds` attribute of
    /// `AutoMLJobCompletionCriteria` defaults to 72h (259200s).
    completion_criteria: ?AutoMLJobCompletionCriteria = null,

    model_access_config: ?ModelAccessConfig = null,

    /// The hyperparameters used to configure and optimize the learning process of
    /// the base model. You can set any combination of the following hyperparameters
    /// for all base models. For more information on each supported hyperparameter,
    /// see [Optimize the learning process of your text generation models with
    /// hyperparameters](https://docs.aws.amazon.com/sagemaker/latest/dg/autopilot-llms-finetuning-set-hyperparameters.html).
    ///
    /// * `"epochCount"`: The number of times the model goes through the entire
    ///   training dataset. Its value should be a string containing an integer value
    ///   within the range of "1" to "10".
    /// * `"batchSize"`: The number of data samples used in each iteration of
    ///   training. Its value should be a string containing an integer value within
    ///   the range of "1" to "64".
    /// * `"learningRate"`: The step size at which a model's parameters are updated
    ///   during training. Its value should be a string containing a floating-point
    ///   value within the range of "0" to "1".
    /// * `"learningRateWarmupSteps"`: The number of training steps during which the
    ///   learning rate gradually increases before reaching its target or maximum
    ///   value. Its value should be a string containing an integer value within the
    ///   range of "0" to "250".
    ///
    /// Here is an example where all four hyperparameters are configured.
    ///
    /// `{ "epochCount":"5", "learningRate":"0.5", "batchSize": "32",
    /// "learningRateWarmupSteps": "10" }`
    text_generation_hyper_parameters: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .base_model_name = "BaseModelName",
        .completion_criteria = "CompletionCriteria",
        .model_access_config = "ModelAccessConfig",
        .text_generation_hyper_parameters = "TextGenerationHyperParameters",
    };
};
