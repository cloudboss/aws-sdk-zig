const AutomatedReasoningPolicyBuildWorkflowDocument = @import("automated_reasoning_policy_build_workflow_document.zig").AutomatedReasoningPolicyBuildWorkflowDocument;

/// Configuration for an iterative policy refinement workflow, including source
/// documents to process and optional feedback to guide the refinement.
pub const AutomatedReasoningPolicyIterativeRefinementContent = struct {
    /// Source documents used for iterative policy refinement. These documents
    /// provide context for refining the policy definition.
    documents: []const AutomatedReasoningPolicyBuildWorkflowDocument,

    /// Optional feedback to guide the iterative refinement workflow. Provide
    /// specific instructions or constraints for policy refinement.
    feedback: ?[]const u8 = null,

    pub const json_field_names = .{
        .documents = "documents",
        .feedback = "feedback",
    };
};
