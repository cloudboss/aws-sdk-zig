/// A list of `IdMappingWorkflowSummary` objects, each of which contain the
/// fields `WorkflowName`, `WorkflowArn`, `CreatedAt`, and `UpdatedAt`.
pub const IdMappingWorkflowSummary = struct {
    /// The timestamp of when the workflow was created.
    created_at: i64,

    /// The timestamp of when the workflow was last updated.
    updated_at: i64,

    /// The ARN (Amazon Resource Name) that Entity Resolution generated for the
    /// `IdMappingWorkflow`.
    workflow_arn: []const u8,

    /// The name of the workflow.
    workflow_name: []const u8,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .updated_at = "updatedAt",
        .workflow_arn = "workflowArn",
        .workflow_name = "workflowName",
    };
};
