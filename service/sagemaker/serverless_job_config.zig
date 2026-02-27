const CustomizationTechnique = @import("customization_technique.zig").CustomizationTechnique;
const EvaluationType = @import("evaluation_type.zig").EvaluationType;
const ServerlessJobType = @import("serverless_job_type.zig").ServerlessJobType;
const Peft = @import("peft.zig").Peft;

/// The configuration for the serverless training job.
pub const ServerlessJobConfig = struct {
    /// Specifies agreement to the model end-user license agreement (EULA). The
    /// `AcceptEula` value must be explicitly defined as `True` in order to accept
    /// the EULA that this model requires. You are responsible for reviewing and
    /// complying with any applicable license terms and making sure they are
    /// acceptable for your use case before downloading or using a model. For more
    /// information, see [End-user license
    /// agreements](https://docs.aws.amazon.com/sagemaker/latest/dg/jumpstart-foundation-models-choose.html#jumpstart-foundation-models-choose-eula) section for more details on accepting the EULA.
    accept_eula: ?bool,

    /// The base model Amazon Resource Name (ARN) in [SageMaker Public
    /// Hub](https://docs.aws.amazon.com/sagemaker/latest/dg/jumpstart-foundation-models-use.html). SageMaker always selects the latest version of the provided model.
    base_model_arn: []const u8,

    /// The model customization technique.
    customization_technique: ?CustomizationTechnique,

    /// The evaluation job type. Required when serverless job type is `Evaluation`.
    evaluation_type: ?EvaluationType,

    /// The evaluator Amazon Resource Name (ARN) used as reward function or reward
    /// prompt.
    evaluator_arn: ?[]const u8,

    /// The serverless training job type.
    job_type: ServerlessJobType,

    /// The parameter-efficient fine-tuning configuration.
    peft: ?Peft,

    pub const json_field_names = .{
        .accept_eula = "AcceptEula",
        .base_model_arn = "BaseModelArn",
        .customization_technique = "CustomizationTechnique",
        .evaluation_type = "EvaluationType",
        .evaluator_arn = "EvaluatorArn",
        .job_type = "JobType",
        .peft = "Peft",
    };
};
