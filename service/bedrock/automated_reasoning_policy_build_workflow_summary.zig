const AutomatedReasoningPolicyBuildWorkflowType = @import("automated_reasoning_policy_build_workflow_type.zig").AutomatedReasoningPolicyBuildWorkflowType;
const AutomatedReasoningPolicyBuildWorkflowStatus = @import("automated_reasoning_policy_build_workflow_status.zig").AutomatedReasoningPolicyBuildWorkflowStatus;

/// Provides a summary of a policy build workflow, including its current status,
/// timing information, and key identifiers.
pub const AutomatedReasoningPolicyBuildWorkflowSummary = struct {
    /// The unique identifier of the build workflow.
    build_workflow_id: []const u8,

    /// The type of build workflow (e.g., DOCUMENT_INGESTION, POLICY_REPAIR).
    build_workflow_type: AutomatedReasoningPolicyBuildWorkflowType,

    /// The timestamp when the build workflow was created.
    created_at: i64,

    /// The Amazon Resource Name (ARN) of the Automated Reasoning policy associated
    /// with this build workflow.
    policy_arn: []const u8,

    /// The current status of the build workflow (e.g., RUNNING, COMPLETED, FAILED,
    /// CANCELLED).
    status: AutomatedReasoningPolicyBuildWorkflowStatus,

    /// The timestamp when the build workflow was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .build_workflow_id = "buildWorkflowId",
        .build_workflow_type = "buildWorkflowType",
        .created_at = "createdAt",
        .policy_arn = "policyArn",
        .status = "status",
        .updated_at = "updatedAt",
    };
};
