const ModelInvocationInput = @import("model_invocation_input.zig").ModelInvocationInput;
const PostProcessingModelInvocationOutput = @import("post_processing_model_invocation_output.zig").PostProcessingModelInvocationOutput;

/// Details about the post-processing step, in which the agent shapes the
/// response.
pub const PostProcessingTrace = union(enum) {
    /// The input for the post-processing step.
    ///
    /// * The `type` is `POST_PROCESSING`.
    /// * The `text` contains the prompt.
    /// * The `inferenceConfiguration`, `parserMode`, and `overrideLambda` values
    ///   are set in the
    ///   [PromptOverrideConfiguration](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent_PromptOverrideConfiguration.html) object that was set when the agent was created or updated.
    model_invocation_input: ?ModelInvocationInput,
    /// The foundation model output from the post-processing step.
    model_invocation_output: ?PostProcessingModelInvocationOutput,

    pub const json_field_names = .{
        .model_invocation_input = "modelInvocationInput",
        .model_invocation_output = "modelInvocationOutput",
    };
};
