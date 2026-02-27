const ModelInvocationInput = @import("model_invocation_input.zig").ModelInvocationInput;
const PreProcessingModelInvocationOutput = @import("pre_processing_model_invocation_output.zig").PreProcessingModelInvocationOutput;

/// Details about the pre-processing step, in which the agent contextualizes and
/// categorizes user inputs.
pub const PreProcessingTrace = union(enum) {
    /// The input for the pre-processing step.
    ///
    /// * The `type` is `PRE_PROCESSING`.
    /// * The `text` contains the prompt.
    /// * The `inferenceConfiguration`, `parserMode`, and `overrideLambda` values
    ///   are set in the
    ///   [PromptOverrideConfiguration](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent_PromptOverrideConfiguration.html) object that was set when the agent was created or updated.
    model_invocation_input: ?ModelInvocationInput,
    /// The foundation model output from the pre-processing step.
    model_invocation_output: ?PreProcessingModelInvocationOutput,

    pub const json_field_names = .{
        .model_invocation_input = "modelInvocationInput",
        .model_invocation_output = "modelInvocationOutput",
    };
};
