const AutomatedReasoningPolicyBuildStepContext = @import("automated_reasoning_policy_build_step_context.zig").AutomatedReasoningPolicyBuildStepContext;
const AutomatedReasoningPolicyBuildStepMessage = @import("automated_reasoning_policy_build_step_message.zig").AutomatedReasoningPolicyBuildStepMessage;
const AutomatedReasoningPolicyDefinitionElement = @import("automated_reasoning_policy_definition_element.zig").AutomatedReasoningPolicyDefinitionElement;

/// Represents a single step in the policy build process, containing context
/// about what was being processed and any messages or results.
pub const AutomatedReasoningPolicyBuildStep = struct {
    /// Contextual information about what was being processed during this build
    /// step, such as the type of operation or the source material being analyzed.
    context: AutomatedReasoningPolicyBuildStepContext,

    /// A list of messages generated during this build step, including informational
    /// messages, warnings, and error details.
    messages: []const AutomatedReasoningPolicyBuildStepMessage,

    /// Reference to the previous element or step in the build process, helping to
    /// trace the sequence of operations.
    prior_element: ?AutomatedReasoningPolicyDefinitionElement = null,

    pub const json_field_names = .{
        .context = "context",
        .messages = "messages",
        .prior_element = "priorElement",
    };
};
