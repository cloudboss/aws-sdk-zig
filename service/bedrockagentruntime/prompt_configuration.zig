const InferenceConfiguration = @import("inference_configuration.zig").InferenceConfiguration;
const CreationMode = @import("creation_mode.zig").CreationMode;
const PromptState = @import("prompt_state.zig").PromptState;
const PromptType = @import("prompt_type.zig").PromptType;

/// Contains configurations to override a prompt template in one part of an
/// agent sequence. For more information, see [Advanced
/// prompts](https://docs.aws.amazon.com/bedrock/latest/userguide/advanced-prompts.html).
pub const PromptConfiguration = struct {
    /// If the Converse or ConverseStream operations support the model,
    /// `additionalModelRequestFields` contains additional inference parameters,
    /// beyond the base set of inference parameters in the `inferenceConfiguration`
    /// field.
    ///
    /// For more information, see *Inference request parameters and response fields
    /// for foundation models* in the Amazon Bedrock user guide.
    additional_model_request_fields: ?[]const u8,

    /// Defines the prompt template with which to replace the default prompt
    /// template. You can use placeholder variables in the base prompt template to
    /// customize the prompt. For more information, see [Prompt template placeholder
    /// variables](https://docs.aws.amazon.com/bedrock/latest/userguide/prompt-placeholders.html). For more information, see [Configure the prompt templates](https://docs.aws.amazon.com/bedrock/latest/userguide/advanced-prompts-configure.html).
    base_prompt_template: ?[]const u8,

    /// The foundation model to use.
    foundation_model: ?[]const u8,

    /// Contains inference parameters to use when the agent invokes a foundation
    /// model in the part of the agent sequence defined by the `promptType`. For
    /// more information, see [Inference parameters for foundation
    /// models](https://docs.aws.amazon.com/bedrock/latest/userguide/model-parameters.html).
    inference_configuration: ?InferenceConfiguration,

    /// Specifies whether to override the default parser Lambda function when
    /// parsing the raw foundation model output in the part of the agent sequence
    /// defined by the `promptType`. If you set the field as `OVERRIDDEN`, the
    /// `overrideLambda` field in the
    /// [PromptOverrideConfiguration](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent_PromptOverrideConfiguration.html) must be specified with the ARN of a Lambda function.
    parser_mode: ?CreationMode,

    /// Specifies whether to override the default prompt template for this
    /// `promptType`. Set this value to `OVERRIDDEN` to use the prompt that you
    /// provide in the `basePromptTemplate`. If you leave it as `DEFAULT`, the agent
    /// uses a default prompt template.
    prompt_creation_mode: ?CreationMode,

    /// Specifies whether to allow the inline agent to carry out the step specified
    /// in the `promptType`. If you set this value to `DISABLED`, the agent skips
    /// that step. The default state for each `promptType` is as follows.
    ///
    /// * `PRE_PROCESSING` – `ENABLED`
    /// * `ORCHESTRATION` – `ENABLED`
    /// * `KNOWLEDGE_BASE_RESPONSE_GENERATION` – `ENABLED`
    /// * `POST_PROCESSING` – `DISABLED`
    prompt_state: ?PromptState,

    /// The step in the agent sequence that this prompt configuration applies to.
    prompt_type: ?PromptType,

    pub const json_field_names = .{
        .additional_model_request_fields = "additionalModelRequestFields",
        .base_prompt_template = "basePromptTemplate",
        .foundation_model = "foundationModel",
        .inference_configuration = "inferenceConfiguration",
        .parser_mode = "parserMode",
        .prompt_creation_mode = "promptCreationMode",
        .prompt_state = "promptState",
        .prompt_type = "promptType",
    };
};
