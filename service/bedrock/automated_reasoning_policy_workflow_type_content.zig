const AutomatedReasoningPolicyBuildWorkflowDocument = @import("automated_reasoning_policy_build_workflow_document.zig").AutomatedReasoningPolicyBuildWorkflowDocument;
const AutomatedReasoningPolicyGenerateFidelityReportContent = @import("automated_reasoning_policy_generate_fidelity_report_content.zig").AutomatedReasoningPolicyGenerateFidelityReportContent;
const AutomatedReasoningPolicyIterativeRefinementContent = @import("automated_reasoning_policy_iterative_refinement_content.zig").AutomatedReasoningPolicyIterativeRefinementContent;
const AutomatedReasoningPolicyBuildWorkflowRepairContent = @import("automated_reasoning_policy_build_workflow_repair_content.zig").AutomatedReasoningPolicyBuildWorkflowRepairContent;

/// Defines the content and configuration for different types of policy build
/// workflows.
pub const AutomatedReasoningPolicyWorkflowTypeContent = union(enum) {
    /// The list of documents to be processed in a document ingestion workflow.
    documents: ?[]const AutomatedReasoningPolicyBuildWorkflowDocument,
    /// The content configuration for generating a fidelity report workflow. This
    /// can include source documents to analyze or an existing fidelity report to
    /// update with a new policy definition.
    generate_fidelity_report_content: ?AutomatedReasoningPolicyGenerateFidelityReportContent,
    /// Content configuration to start an iterative policy refinement workflow that
    /// uses generative AI to automatically make changes to the policy based on test
    /// results and the optional feedback provided.
    iterative_refinement_content: ?AutomatedReasoningPolicyIterativeRefinementContent,
    /// The assets and instructions needed for a policy repair workflow, including
    /// repair annotations and guidance.
    policy_repair_assets: ?AutomatedReasoningPolicyBuildWorkflowRepairContent,

    pub const json_field_names = .{
        .documents = "documents",
        .generate_fidelity_report_content = "generateFidelityReportContent",
        .iterative_refinement_content = "iterativeRefinementContent",
        .policy_repair_assets = "policyRepairAssets",
    };
};
