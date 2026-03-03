const InferenceConfiguration = @import("inference_configuration.zig").InferenceConfiguration;
const CreationMode = @import("creation_mode.zig").CreationMode;
const PromptType = @import("prompt_type.zig").PromptType;

/// The input for the pre-processing step.
///
/// * The `type` matches the agent step.
/// * The `text` contains the prompt.
/// * The `inferenceConfiguration`, `parserMode`, and `overrideLambda` values
///   are set in the
///   [PromptOverrideConfiguration](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent_PromptOverrideConfiguration.html) object that was set when the agent was created or updated.
pub const ModelInvocationInput = struct {
    /// The identifier of a foundation model.
    foundation_model: ?[]const u8 = null,

    /// Specifications about the inference parameters that were provided alongside
    /// the prompt. These are specified in the
    /// [PromptOverrideConfiguration](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent_PromptOverrideConfiguration.html) object that was set when the agent was created or updated. For more information, see [Inference parameters for foundation models](https://docs.aws.amazon.com/bedrock/latest/userguide/model-parameters.html).
    inference_configuration: ?InferenceConfiguration = null,

    /// The ARN of the Lambda function to use when parsing the raw foundation model
    /// output in parts of the agent sequence.
    override_lambda: ?[]const u8 = null,

    /// Specifies whether to override the default parser Lambda function when
    /// parsing the raw foundation model output in the part of the agent sequence
    /// defined by the `promptType`.
    parser_mode: ?CreationMode = null,

    /// Specifies whether the default prompt template was `OVERRIDDEN`. If it was,
    /// the `basePromptTemplate` that was set in the
    /// [PromptOverrideConfiguration](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent_PromptOverrideConfiguration.html) object when the agent was created or updated is used instead.
    prompt_creation_mode: ?CreationMode = null,

    /// The text that prompted the agent at this step.
    text: ?[]const u8 = null,

    /// The unique identifier of the trace.
    trace_id: ?[]const u8 = null,

    /// The step in the agent sequence.
    @"type": ?PromptType = null,

    pub const json_field_names = .{
        .foundation_model = "foundationModel",
        .inference_configuration = "inferenceConfiguration",
        .override_lambda = "overrideLambda",
        .parser_mode = "parserMode",
        .prompt_creation_mode = "promptCreationMode",
        .text = "text",
        .trace_id = "traceId",
        .@"type" = "type",
    };
};
