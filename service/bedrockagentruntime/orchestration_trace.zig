const InvocationInput = @import("invocation_input.zig").InvocationInput;
const ModelInvocationInput = @import("model_invocation_input.zig").ModelInvocationInput;
const OrchestrationModelInvocationOutput = @import("orchestration_model_invocation_output.zig").OrchestrationModelInvocationOutput;
const Observation = @import("observation.zig").Observation;
const Rationale = @import("rationale.zig").Rationale;

/// Details about the orchestration step, in which the agent determines the
/// order in which actions are executed and which knowledge bases are retrieved.
pub const OrchestrationTrace = union(enum) {
    /// Contains information pertaining to the action group or knowledge base that
    /// is being invoked.
    invocation_input: ?InvocationInput,
    /// The input for the orchestration step.
    ///
    /// * The `type` is `ORCHESTRATION`.
    /// * The `text` contains the prompt.
    /// * The `inferenceConfiguration`, `parserMode`, and `overrideLambda` values
    ///   are set in the
    ///   [PromptOverrideConfiguration](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent_PromptOverrideConfiguration.html) object that was set when the agent was created or updated.
    model_invocation_input: ?ModelInvocationInput,
    /// Contains information pertaining to the output from the foundation model that
    /// is being invoked.
    model_invocation_output: ?OrchestrationModelInvocationOutput,
    /// Details about the observation (the output of the action group Lambda or
    /// knowledge base) made by the agent.
    observation: ?Observation,
    /// Details about the reasoning, based on the input, that the agent uses to
    /// justify carrying out an action group or getting information from a knowledge
    /// base.
    rationale: ?Rationale,

    pub const json_field_names = .{
        .invocation_input = "invocationInput",
        .model_invocation_input = "modelInvocationInput",
        .model_invocation_output = "modelInvocationOutput",
        .observation = "observation",
        .rationale = "rationale",
    };
};
