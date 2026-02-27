const AutomatedReasoningPolicyBuildWorkflowDocument = @import("automated_reasoning_policy_build_workflow_document.zig").AutomatedReasoningPolicyBuildWorkflowDocument;
const AutomatedReasoningPolicyBuildWorkflowRepairContent = @import("automated_reasoning_policy_build_workflow_repair_content.zig").AutomatedReasoningPolicyBuildWorkflowRepairContent;

/// Defines the content and configuration for different types of policy build
/// workflows.
pub const AutomatedReasoningPolicyWorkflowTypeContent = union(enum) {
    /// The list of documents to be processed in a document ingestion workflow.
    documents: ?[]const AutomatedReasoningPolicyBuildWorkflowDocument,
    /// The assets and instructions needed for a policy repair workflow, including
    /// repair annotations and guidance.
    policy_repair_assets: ?AutomatedReasoningPolicyBuildWorkflowRepairContent,

    pub const json_field_names = .{
        .documents = "documents",
        .policy_repair_assets = "policyRepairAssets",
    };
};
