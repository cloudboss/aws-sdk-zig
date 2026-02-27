/// Specifies the workflow ID for the workflow to assign and the execution role
/// that's used for executing the workflow.
///
/// In addition to a workflow to execute when a file is uploaded completely,
/// `WorkflowDetails` can also contain a workflow ID (and execution role) for a
/// workflow to execute on partial upload. A partial upload occurs when the
/// server session disconnects while the file is still being uploaded.
pub const WorkflowDetail = struct {
    /// Includes the necessary permissions for S3, EFS, and Lambda operations that
    /// Transfer can assume, so that all workflow steps can operate on the required
    /// resources
    execution_role: []const u8,

    /// A unique identifier for the workflow.
    workflow_id: []const u8,

    pub const json_field_names = .{
        .execution_role = "ExecutionRole",
        .workflow_id = "WorkflowId",
    };
};
