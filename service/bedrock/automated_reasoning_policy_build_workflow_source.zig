const AutomatedReasoningPolicyDefinition = @import("automated_reasoning_policy_definition.zig").AutomatedReasoningPolicyDefinition;
const AutomatedReasoningPolicyWorkflowTypeContent = @import("automated_reasoning_policy_workflow_type_content.zig").AutomatedReasoningPolicyWorkflowTypeContent;

/// Defines the source content for a policy build workflow, which can include
/// documents, repair instructions, or other input materials.
pub const AutomatedReasoningPolicyBuildWorkflowSource = struct {
    /// An existing policy definition that serves as the starting point for the
    /// build workflow, typically used in policy repair or update scenarios.
    policy_definition: ?AutomatedReasoningPolicyDefinition = null,

    /// The actual content to be processed in the build workflow, such as documents
    /// to analyze or repair instructions to apply.
    workflow_content: ?AutomatedReasoningPolicyWorkflowTypeContent = null,

    pub const json_field_names = .{
        .policy_definition = "policyDefinition",
        .workflow_content = "workflowContent",
    };
};
