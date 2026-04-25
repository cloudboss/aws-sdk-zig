const AutomatedReasoningPolicyBuildWorkflowDocument = @import("automated_reasoning_policy_build_workflow_document.zig").AutomatedReasoningPolicyBuildWorkflowDocument;

/// Configuration for generating a fidelity report, which can either analyze new
/// documents or update an existing fidelity report with a new policy
/// definition.
pub const AutomatedReasoningPolicyGenerateFidelityReportContent = union(enum) {
    /// Source documents to analyze for generating a new fidelity report. The
    /// documents will be processed to create atomic statements and grounding
    /// information.
    documents: ?[]const AutomatedReasoningPolicyBuildWorkflowDocument,

    pub const json_field_names = .{
        .documents = "documents",
    };
};
